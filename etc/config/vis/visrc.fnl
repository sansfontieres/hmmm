(require :plugins/vis-modelines)
(require :plugins/vis-filetype-settings/vis-filetype-settings)
(require :plugins/vis-quickfix)
(require :plugins/vis-commentary)
(require :plugins/vis-sneak)
(require :plugins/vis-ctags)
(require :plugins/vis-tmux-repl/tmux-repl)
(require :plugins/vis-goto-file)

(local plugin-vis-open (require :plugins/vis-fzf-open))

(global settings {:markdown ["set et on" "set tw 2" "set cc 73"]
                  :lua ["set tw 4" "set et off"]
                  :pascal ["set et on" "set tw 2" "set cc 81"]
                  :zig ["set tw 4" "set et on"]
                  :ansi_c ["set et on" "set tw 2" "set cc 81"]
                  :cpp ["set et off" "set tw 8" "set cc 81"]
                  :go ["set et off" "set tw 4"]
                  :sh ["set et off" "set tw 4"]
                  :js ["set et on" "set tw 2"]
                  :html ["set et on" "set tw 2"]
                  :ruby ["set et on" "set tw 2"]
                  :css ["set et on" "set tw 2"]
                  :yaml ["set et on" "set tw 2"]
                  :python ["set et on" "set tw 4"]})

(set plugin-vis-open.fzf_path
     "FZF_DEFAULT_COMMAND='rg --hidden --smart-case --line-number --with-filename . --field-match-separator \" \" ' fzf")

(set plugin-vis-open.fzf_args
     "--height=25% --preview 'bat --color=always {1} --highlight-line {2}'")

(set vis.shell :/usr/local/pla9/bin/rc)

;; fnlfmt: skip
(local colors {:bg_0 "#fdfdfc"
               :bg_1 "#ebebeb"
               :bg_2 "#cccccc"
               :md_0 "#858585"
               :md_1 "#5c5c5c"
               :fg_0 "#3d3d3d"
               :fg_1 "#2a2a2a"

               :red "#d11100"
               :green "#309900"
               :yellow "#c79800"
               :blue "#0063db"
               :magenta "#d4008d"
               :cyan "#00b8a5"

               :bred "#b80f00"
               :bgreen "#218f00"
               :byellow "#b38900"
               :bblue "#0059d2"
               :bmagenta "#b8007a"
               :bcyan "#009485"

               :mblue "#587ae2"

               :gold "#846d21"
               :specials "#fed200"
               :orange "#db6600"
               :selection "#e2e3fa"})

;; fnlfmt: skip
(vis.events.subscribe vis.events.INIT
                      (fn []
                        (vis:command "set tabwidth 4")
                        (vis:command "set autoindent on")
                        (vis:command "set ignorecase")

                        ;; Hito color scheme
                        (local lexers vis.lexers)
                        (set lexers.STYLE_DEFAULT (.. "fore:" colors.fg_1 ",back:" colors.bg_0))
                        (set lexers.STYLE_NOTHING (.. "back:" colors.bg_0))
                        (set lexers.STYLE_CLASS :bold)
                        (set lexers.STYLE_COMMENT (.. "fore:" colors.md_0 ",italics"))
                        (set lexers.STYLE_CONSTANT :bold)
                        (set lexers.STYLE_DEFINITION (.. "fore:" colors.orange))
                        (set lexers.STYLE_ERROR (.. "fore:" colors.red ",italics"))
                        (set lexers.STYLE_FUNCTION :bold)
                        (set lexers.STYLE_KEYWORD :bold)
                        (set lexers.STYLE_LABEL (.. "fore:" colors.green))
                        (set lexers.STYLE_NUMBER (.. "fore:" colors.md_1))
                        (set lexers.STYLE_OPERATOR (.. "fore:" colors.md_0))
                        (set lexers.STYLE_REGEX "fore:green")
                        (set lexers.STYLE_STRING (.. "fore:" colors.blue))
                        (set lexers.STYLE_PREPROCESSOR (.. "fore:" colors.orange))
                        (set lexers.STYLE_TAG (.. "fore:" colors.fg_0))
                        (set lexers.STYLE_TYPE (.. "fore:" colors.gold))
                        (set lexers.STYLE_VARIABLE (.. "fore:" colors.bcyan))
                        (set lexers.STYLE_WHITESPACE "")
                        (set lexers.STYLE_EMBEDDED (.. "back:" colors.bg_1 ",fore:" colors.gold))
                        (set lexers.STYLE_IDENTIFIER (.. "fore:" colors.fg_1))

                        (set lexers.STYLE_LINENUMBER (.. "fore:" colors.md_1))
                        (set lexers.STYLE_LINENUMBER_CURSOR (.. "fore:" colors.md_1 ",back:" colors.specials))
                        (set lexers.STYLE_CURSOR (.. "fore:" colors.bg_2 ",back:" colors.orange))
                        (set lexers.STYLE_CURSOR_PRIMARY (.. "fore:" colors.bg_0 ",back:" colors.orange))
                        (set lexers.STYLE_CURSOR_LINE lexers.STYLE_DEFAULT)
                        (set lexers.STYLE_COLOR_COLUMN (.. "back:" colors.bg_1 ",fore:" colors.red))
                        (set lexers.STYLE_SELECTION (.. "back:" colors.selection))
                        (set lexers.STYLE_STATUS (.. "back:" colors.bg_2 ",fore:" colors.md_0))
                        (set lexers.STYLE_STATUS_FOCUSED (.. "back:" colors.bg_2 ",fore:" colors.bmagenta))
                        (set lexers.STYLE_SEPARATOR lexers.STYLE_DEFAULT)
                        (set lexers.STYLE_INFO "fore:default,back:default,bold")))

(fn nmap [k b]
  (vis:map vis.modes.NORMAL k b))

(fn vmap [k b]
  (vis:map vis.modes.VISUAL k b))

(fn imap [k b]
  (vis:map vis.modes.VISUAL k b))

(nmap " y" "\"+y")
(nmap " p" "\"+p")
(vmap " y" "\"+y")
(vmap " p" "\"+p")
(nmap :<M-s> ":w<Enter>")
(nmap :zz ":q!<Enter>")
(imap "<M- >" :<C-k>)
(vmap :gw ":|par w72gqr<Enter>")
(vmap :gq ":|par w80gqr<Enter>")
(nmap " w"
      ":set show-tabs!<Enter>:set show-newlines!<Enter>:set show-spaces!<Enter>")

(nmap :<C-p> ":fzf<Enter>")

(fn set-title [title]
  (vis:command (string.format ":!printf '\\033]0;%s\\007'" title)))

(vis.events.subscribe vis.events.WIN_OPEN
                      (fn [win]
                        (vis:command "set relativenumber")
                        (vis:command "set show-eof off")
                        (vis:command "set cursorline on")
                        (set-title (or win.file.name "[No Name]"))))

(vis.events.subscribe vis.events.FILE_SAVE_POST
                      (fn [file path]
                        (set-title file.name)))

(set vis.ftdetect.filetypes.email
     {:ext ["%.eml$"] :cmd ["set colorcolumn 72" "set autoindent off"]})

(set vis.ftdetect.filetypes.xml {:ext ["%.glif$"]})

(set vis.ftdetect.filetypes.rails {:ext ["%.rb$"]})

(set vis.ftdetect.filetypes.janet
     {:ext ["%.janet$"] :cmd ["set syntax janet" "set et on" "set tw 2"]})

(nmap " t1" ":<timestamp h1<Enter>")
(nmap " t2" ":<timestamp h2<Enter>")

(fn fmt [file path]
  (var fmt-cmd nil)
  (local lang vis.win.syntax)
  (if (= lang :go) (set fmt-cmd :gofmt)
      (= lang :zig) (set fmt-cmd "zig fmt --stdin")
      (= lang :janet) (set fmt-cmd
                           "janet -e '(use spork)(def src (file/read stdin :all))(fmt/format-print src)'")
      (= lang :fennel) (set fmt-cmd "fnlfmt -")
      (= lang :ansi_c) (set fmt-cmd :clang-format)
      (lua "return true"))
  (local pos vis.win.selection.pos)
  (local (status out err) (vis:pipe file {:start 0 :finish file.size} fmt-cmd))
  (when (or (not= status 0) (not out))
    (when err
      (vis:info err))
    (lua "return false"))
  (file:delete 0 file.size)
  (file:insert 0 out)
  (set vis.win.selection.pos pos)
  true)

(vis.events.subscribe vis.events.FILE_SAVE_PRE fmt)

