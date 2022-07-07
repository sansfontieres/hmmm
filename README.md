Editable Text Configuration
===========================
> Or dotfiles as they say 👴


How does this work ??
---------------------
You need janet to run the script `ninja.janet`, which generates a
`build.ninja` file. To get this mess to work, you want to run the
following:

```sh
; ./ninja.janet
info: You may run samurai :^)
; samu
[1/5] cp hgrc /home/r/.config/hg/hgrc
--8<--
; samu recipe-vis
[1/1] scripts/recipe_vis
--8<--
```

Of course you can use ninja instead of samurai, or even move those files
yourself :^) <!-- lol -->


Setup
-----
If zig is not installed, the script `get_zig.sh` takes care of it. Same
story with `get_janet.sh` or `get_fennel.sh` which will checkout the
lattest tagged commit from their repository.

To build the prompt, run `scripts/pick_prompt.sh` which will compile
either the prompt in Pascal, Zig, or generate a script that prints a
simple prompt, depending on available compilers.
