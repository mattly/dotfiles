IGNORE = Readme.md Makefile .git .gitignore install
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env

ready:
	@open https://github.com/kennethreitz/osx-gcc-installer
	@open https://code.google.com/p/iterm2/downloads/list

symlinks:
	@$(foreach FILE, $(FILES), [ -h ~/.$(FILE) ] \
		&& echo "skipping $(FILE)" \
		|| ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;)
	@$(foreach FILE, $(EMPTIES), touch ~/.$(FILE) ;)

shell:
	@echo /usr/local/bin/fish >> /etc/shells
	@chsh -s /usr/local/bin/fish $(SUDO_USER)

.PHONY: symlinks shell ready
