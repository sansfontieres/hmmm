bind -qa $home/bin/rc /bin
bind -qa $home/bin/$cputype /bin
bind -qa $home/lib/bin /bin
bind -qa $home/lib/bin/git /bin/git
bind -qa $home/lib/bin/acme /acme/bin

fontlib=$home/lib/font/bit
fontsize=14
monospace=$fontlib/pragmata/pragmata.$fontsize.font
fontsize=16
sans=$fontlib/inter/inter.$fontsize.font
font=$sans
tabstop=2

domain=grtsk.com

mailserver=fastmail.com
mailuser=telecom@sansfontieres.com
maildirs=(Inbox Archive Sent 9 Feed Lobsters Miscs-Lists OpenBSD sr.ht-discuss Todo)

fn open_mailboxes {
	upas/fs -f /imaps/imap.$mailserver/$mailuser
	for(i in $maildirs){
		echo open /imaps/imap.$mailserver/$mailuser/$i $i > /mail/fs/ctl &
	}
}

fn load_factotum{
	ipso -l || load_factotum
}

fn setup_secstore{ # see /cfg/$sysname/termrc
	secstore=tcp!127.0.0.1!5356
	auth/secstored -s $secstore
	load_factotum
}

fn wifi{
	grep node '#l1'/ether1/ifstats
	echo -n 'essid='
	essid=`{read}
	bind -a '#l1' /net
	aux/wpa -s $essid -p /net/ether1
	ip/ipconfig ether /net/ether1
}

switch($service){
case terminal
	webcookies
	webfs
	setup_secstore
	wifi
	plumber
	open_mailboxes
	echo -n accelerated > '#m/mousectl'
	echo -n 'res 3' > '#m/mousectl'
	prompt=('; ' '	')
	fn term%{ $* }
	rio -si riostart
case cpu
	bind /mnt/term/dev/cons /dev/cons
	bind -q /mnt/term/dev/consctl /dev/consctl
	>[2] /dev/null {
		cp /dev/sysname /mnt/term/dev/label
		if(wsys=`{cat /mnt/term/env/wsys} && ~ $#wsys 1) {
			wsys=/mnt/term^$wsys
		}
		if not {
			wsys=()
		}
	} 
	bind -a /mnt/term/dev /dev
	prompt=(''$sysname'; ' '	')
	fn cpu%{ $* }
	if(! test -e /mnt/term/dev/wsys){
		# call from drawterm
		if(test -e /mnt/term/dev/secstore){
			auth/factotum -n
			read -m /mnt/term/dev/secstore >/mnt/factotum/ctl
			echo >/mnt/term/dev/secstore
		}
		if not
			auth/factotum
		webcookies
		webfs
		plumber
		rio
	}
case con
	prompt=('cpu% ' '	')
}

# Some aliases
fn vis{s $*}
fn sma{s  $*}
