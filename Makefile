ready:
	@open https://github.com/kennethreitz/osx-gcc-installer
	@open https://code.google.com/p/iterm2/downloads/list

install: symlinks ware vim/bundle/vundle

symlinks:
	IGNORE = Readme.md Makefile .git .gitignore install
	FILES = $(filter-out $(IGNORE), $(wildcard *))
	EMPTIES = env
	@$(foreach FILE, $(FILES), [ -h ~/.$(FILE) ] \
		&& echo "skipping $(FILE)" \
		|| ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;)
	@$(foreach FILE, $(EMPTIES), touch ~/.$(FILE) ;)

ware:
	$(shell install/bork)

shell:
	@echo /usr/local/bin/fish >> /etc/shells
	@chsh -s /usr/local/bin/fish $(SUDO_USER)

vim/bundle/vundle:
	@vim +BundleInstall +qall

.PHONY: install symlinks ware shell ready
