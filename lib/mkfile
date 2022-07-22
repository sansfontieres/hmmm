</$objtype/mkfile

all = $home/lib/profile $home/lib/plumbing $home/lib/git $home/lib/bin /cfg/$sysname $home/lib/themes $objtype/bin/prompt

all:V: $all

clean:V:
	rm -rf $all

$home/lib/profile: profile
	cp $prereq $target

$home/lib/plumbing: plumbing
	cp $prereq $target

$home/lib/git: git
	rm -rf $target
	clone $prereq $target

$home/lib/themes: themes
	rm -rf $target
	clone $prereq $target

$home/lib/bin: bin
	rm -f $target/*
	rm -f $target/git/*
	rm -f $target/acme/*
	mkdir -p $target/git
	mkdir -p $target/acme
	cp $prereq/git/* $target/git/
	cp $prereq/acme/* $target/acme/
	cp $prereq/* $target

/cfg/$sysname: cfg/$sysname
	rm -rf $target
	clone $prereq $target

/$objtype/bin/prompt: prompt.$O
	$LD -o $target $prereq

%.$O: %.c
	$CC $CFLAGS src/$stem.c
