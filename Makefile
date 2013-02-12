IGNORE = Readme.md Makefile .git .gitignore install
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env
HOMEBREW = ack bcrypt curl hub nmap node postgresql python rbenv readline \
		   reattach-to-user-namespace redis ruby-build tig tmux vim

install: install_dotfiles install_brew_packs

install_dotfiles:
	@$(foreach FILE, $(FILES), \
		ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;\
	 )
	@$(foreach FILE, $(EMPTIES), \
		touch ~/.$(FILE) ;\
	 )
	@mkdir -p ~/.zsh_cache

install_brew_packs:
	@$(foreach PKG, $(HOMEBREW), \
		brew install $(PKG) ;\
	 )

.PHONY: install
