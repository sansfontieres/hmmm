require("vis")
require("plugins/vis-modelines")
require("plugins/vis-filetype-settings/vis-filetype-settings")
require("plugins/vis-quickfix")
require("plugins/vis-janet")
require("plugins/vis-zig")
require("plugins/vis-commentary")
require("plugins/vis-sneak")
require("plugins/vis-ctags")
require("plugins/vis-tmux-repl/tmux-repl")
plugin_vis_open = require('plugins/vis-fzf-open')

settings = {
	markdown = {"set tw 3", "set et on"},
	lua = {"set tw 4", "set et off"},
	zig = {"set tw 4", "set et on"},
	ansi_c = {"set et off", "set tw 8", "set cc 81"},
	cpp = {"set et off", "set tw 8", "set cc 81"},
	go = {"set et off", "set tw 4"},
	sh = {"set et off", "set tw 4"},
	js = {"set et on", "set tw 2"},
	typescript = {"set et on", "set tw 2"},
	html = {"set et on", "set tw 2"},
	ruby = {"set et on", "set tw 2"},
	scss = {"set et on", "set tw 2"},
	css = {"set et on", "set tw 2"},
	yaml = {"set et on", "set tw 2"},
	markdown = {"set et on", "set tw 2", "set cc 73"},
	python = {"set et on", "set tw 4"},
}

plugin_vis_open.fzf_path = (
	"FZF_DEFAULT_COMMAND='rg --files --hidden -g \"!.git/\" -g \"\"' fzf"
)
plugin_vis_open.fzf_args = "-q '!.class ' --height=20%"
vis.events.subscribe(vis.events.INIT, function()
	vis:command('map! normal <C-p> :fzf<Enter>')
end)

local function set_title(title)
	vis:command(string.format(":!printf '\\033]0;%s\\007'", title))
end

vis.events.subscribe(vis.events.INIT, function()
	vis:command("set theme hito")
	vis:command("set tabwidth 4")
	vis:command("set autoindent on")
	vis:command("set ignorecase")


	vis:map(vis.modes.NORMAL, ' y',    '"+y')
	vis:map(vis.modes.NORMAL, ' p',    '"+p')
	vis:map(vis.modes.VISUAL, ' y',    '"+y')
	vis:map(vis.modes.VISUAL, ' p',    '"+p')
	vis:map(vis.modes.NORMAL, '<M-s>', ':w<Enter>')
	vis:map(vis.modes.NORMAL, 'zz',    ':q!<Enter>')
	vis:map(vis.modes.INSERT, '<M- >', '<C-k>')
	vis:map(vis.modes.VISUAL, 'gw',    ':|par w72gqr<Enter>')
	vis:map(vis.modes.VISUAL, 'gq',    ':|par w80gqr<Enter>')
	vis:map(vis.modes.NORMAL, ' w',    ':set show-tabs!<Enter>:set show-newlines!<Enter>:set show-spaces!<Enter>')
	vis:map(vis.modes.NORMAL, ' d',    ':n<Enter>:<')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command("set relativenumber")
	vis:command("set show-eof off")
	vis:command("set cursorline on")
	set_title(win.file.name or '[No Name]')
end)

vis.events.subscribe(vis.events.FILE_SAVE_POST, function(file, path)
	set_title(file.name)
end)

vis.ftdetect.filetypes.email = {
	ext = { "%.eml$" },
	cmd = { "set colorcolumn 72", "set autoindent off"},
}

vis.ftdetect.filetypes.xml = {
	ext = { "%.glif$" },
}

vis.ftdetect.filetypes.janet = {
	ext = { "%.janet$" },
	cmd = { "set syntax janet", "set et on", "set tw 2" },
}
