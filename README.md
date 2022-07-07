# Editable Text Configuration

> Or dotfiles as they say 👴


## How does this work ??

The zig code in `ninja.zig` generates a `build.ninja` file. To get this mess to
work, you want to run the following:

```sh
; curl https://ziglang.org/download/index.json -o zig.json
; zig run ninja.zig
info: Creating a build.ninja file
info: You may run samurai :^)
; samu
[1/5] cp hgrc /home/r/.config/hg/hgrc
...
```

Of course you can use ninja instead of samurai, but why would you?

The script also generates a `scripts` directory holding scripts that setups
installation or configurations when needed.

If zig is not installed, the script `get_zig.sh` takes care of it. The zig code
includes samurai to the list of packages to install.
