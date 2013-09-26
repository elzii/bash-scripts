

function cloneshit() {
	if [ $a == "Y" || $a == "y" || $a == "" ] 
	then
		defaultdir

	else
		altdir
	fi
}


function defaultdir() {
	cd /Users/elzi/gitrepos/
	authrepo
}

function altdir() {
	echo -e -n "fine then. what directory? > "
	read altclonedir
	mkdir $altclonedir
	cd $altclonedir
	authrepo
}

function authrepo() {
    echo -e -n "repo author? > "
	read gitcauthor

	echo -e -n "project name? > "
	read gitcproj

	getitties
}

function gititties() {
	git clone https://github.com/$gitcauthor/$gitcproj/
	echo -e "\033[32mCOMPLETE\033[37m - $gitcauthor/$gitcproj cloned to $clonedir"
	echo -e -n "clone to default directory? \033[30m~/gitrepos033[37m \033[33m[\033[32my\033[33m/\033[31mn\033[33m]\033[37m > "
}
