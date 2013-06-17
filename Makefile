IGNORE = Readme.md Makefile .git .gitignore install
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env

ready:
	@open https://github.com/kennethreitz/osx-gcc-installer
	@open https://code.google.com/p/iterm2/downloads/list

install: symlinks brew nodenv vim/bundle/vundle

symlinks:
	@$(foreach FILE, $(FILES), ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;)
	@$(foreach FILE, $(EMPTIES), touch ~/.$(FILE) ;)

HOMEBREW = \
	readline bcrypt \
	rbenv ruby-build \
	postgresql redis riak \
	hub tig \
	ack curl nmap \
	tmux reattach-to-user-namespace \
	fish \
	mercurial vim \
	dnsmasq

HB_TO_INSTALL = $(filter-out $(shell brew list), $(HOMEBREW))

brew:
	@brew update
	@$(foreach PKG, $(HB_TO_INSTALL), brew install $(PKG) ;)

nodenv:
	@git clone -b v0.2.2 https://github.com/OiNutter/nodenv.git ~/.nodenv
nodenv-build:
	@git clone -b https://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build

shell:
	@echo /usr/local/bin/fish >> /etc/shells
	@chsh -s /usr/local/bin/fish $(SUDO_USER)

vim/bundle/vundle:
	@mkdir -p vim/bundle
	@git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@vim +BundleInstall +qall

.PHONY: install symlinks brew shell ready nodenv nodenv-build
