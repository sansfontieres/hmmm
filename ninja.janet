#!/usr/bin/env janet

(def packages @[
	{:title "mercurial" :source "hgrc" :target ".config/hg/hgrc" :recipe false} # pm: hg-git
	{:title "git" :source "gitconfig" :target ".config/git/config" :recipe false} # pm: git-delta
	{:title "zsh" :source "zshrc" :target ".zshrc" :recipe false}
	{:title "vis" :source "visrc.lua" :target ".config/vis/visrc.lua" :recipe true}
	{:title "vim" :source "vimrc" :target ".vimrc" :recipe true} # pm: gvim-huge OR macvim +huge
	{:title "tmux" :source "tmux.conf" :target ".tmux.conf" :recipe false}
	{:title "bat" :source "bat" :target ".config/bat/config" :recipe true}
	{:title "mbsync" :source "mbsyncrc" :target ".mbsyncrc" :recipe false}
	{:title "mutt" :source "muttrc" :target ".config/mutt/muttrc" :recipe true} # pm: psi fork
	{:title "notmuch" :source "notmuch-config" :target ".notmuch-config" :recipe false}
	{:title "msmtp" :source "msmtprc" :target ".msmtpcrc" :recipe false}])

(def copy_rule
``rule copy
  command = cp $in $out``)

(def recipe_rule
``rule exe
  command = $in``)

(def home (os/getenv "HOME"))

(spit "build.ninja" (
	string/format "home=%s\n%s\n%s\n" home copy_rule recipe_rule))

(each package packages (
	let [{:title title :source source :target target :recipe recipe} package]
		(spit "build.ninja" (
			string/format "build $home/%s: copy configs/%s\n" target  source) :a)
		(spit "build.ninja" (
			string/format "build %s: phony $home/%s\n" title target) :a)
		(spit "build.ninja" (
			string/format "default %s\n" title) :a)
		(if recipe (
			spit "build.ninja" (
				string/format "build recipe-%s: exe scripts/recipe_%s\n" title title) :a)
		)))

(print "info: You may run samu now :^)")
