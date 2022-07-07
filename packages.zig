const Package = struct {
    title: []const u8,
    name: ?[]const u8,
    name_macos: ?[]const u8 = null,
    file: ?[]const u8 = null,
    target: ?[]const u8 = null,
    script: ?[]const u8 = null,
};

pub const packages = [_]Package{
    Package{
        .title = "samurai",
        .name = "samurai",
    },
    Package{
        .title = "mercurial",
        .name = "mercurial hg-git",
        .file = "hgrc",
        .target = ".config/hg/hgrc",
    },
    Package{
        .title = "git",
        .name = "git",
        .file = "gitconfig",
        .target = ".config/git/config",
    },
    Package{
        .title = "zsh",
        .name = "zsh",
        .file = "zshrc",
        .target = ".zshrc",
    },
    Package{
        .title = "vim",
        .name = "gvim-huge",
        .name_macos = "macvim +huge",
        .file = "vimrc",
        .target = ".vimrc",
        .script = 
        \\git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
        \\vim +PackUpdate
        \\vim +Colortemplate! +qall vim_colors/hitodama.colortemplate
        \\mkdir -p $HOME/.vim/colors
        \\mv -i vim_colors/colors/hito.vim $HOME/.vim/colors
        ,
    },
    Package{
        .title = "ssh",
        .name = "openssh mosh",
        .file = "ssh",
        .target = ".ssh/config",
    },
    Package{
        .title = "zls",
        .name = "xz",
        .script =
            \\mkdir -p $HOME/.local/zls
            \\cd $HOME/.local/zls
            \\curl -L https://github.com/zigtools/zls/releases/download/0.1.0/x86_64-linux.tar.xz | tar -xJ --strip-components=1 -C .
            ,
    },
};
