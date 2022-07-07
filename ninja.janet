#!/usr/bin/env janet

(def packages @[{:title "mercurial" :source "hgrc" :target ".config/hg/hgrc"} # pm: hg-git
                {:title "git" :source "gitconfig" :target ".config/git/config"} # pm: git-delta
                {:title "zsh" :source "zshrc" :target ".zshrc"}
                {:title "vis" :source "visrc.fnl" :target ".config/vis/visrc.fnl" :recipe true}
                {:title "vim" :source "vimrc" :target ".vimrc" :recipe true} # pm: gvim-huge OR macvim +huge
                {:title "tmux" :source "tmux.conf" :target ".tmux.conf"}
                {:title "bat" :source "batrc" :target ".config/bat/config" :recipe true}
                {:title "mbsync" :source "mbsyncrc" :target ".mbsyncrc" :directory "email"}
                {:title "mutt" :source "muttrc" :target ".config/mutt/muttrc" :recipe true :directory "email"} # pm: psi fork
                {:title "notmuch" :source "notmuch-config" :target ".notmuch-config" :directory "email"}
                {:title "msmtp" :source "msmtprc" :target ".msmtpcrc" :directory "email"}])

(def copy_rule
  ``rule copy
    command = cp $in $out``)

(def recipe_rule
  ``rule exe
    command = $in``)

(def home (os/getenv "HOME"))

(spit "build.ninja" (string/format "home=%s\n%s\n%s\n" home copy_rule recipe_rule))

(each package packages (let [{:title title :source source :target target :recipe recipe :directory directory} package]
                         (default recipe false)
                         (default directory title)
                         (spit "build.ninja" (string/format "build $home/%s: copy config/%s/%s\n" target directory source) :a)
                         (spit "build.ninja" (string/format "build %s: phony $home/%s\n" title target) :a)
                         (spit "build.ninja" (string/format "default %s\n" title) :a)
                         (if recipe (spit "build.ninja" (string/format "build recipe-%s: exe scripts/recipe_%s\n" title title) :a))))

(print "info: You may run samu now :^)")
