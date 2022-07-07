Editable Text Configuration
===========================
> Or dotfiles as they say 👴


How does this work ??
---------------------
You need janet to run the script `scripts/ninja.rc`, which generates a
`build.ninja` file. To get this mess to work, you want to run the
following:

```sh
; ./scripts/ninja.rc
info: You may run samurai :^)
; samu
[1/5] cp hgrc /home/r/.config/hg/hgrc
--8<--
; samu recipe-vis
[1/1] ./scripts/recipe_vis
--8<--
```

Of course you can use ninja instead of samurai, or even move those files
yourself :^) <!-- lol -->


Setup
-----
To get plan9port, (needed for `rc`) run `get_plan9port.sh`.

If zig is not installed, the script `get_zig.rc` in the `scripts`
directory takes care of it. Same story with `get_janet.rc` or
`get_fennel.rc` which will checkout the latest tagged commit from their
repository.

A set of scripts and utilities are in another repository. It can be
cloned and deployed with `scripts/tools.rc`. It’s mandatory to run it to
install the shell prompt.
