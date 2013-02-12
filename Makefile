IGNORE = Readme.md Makefile .git .gitignore install
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env

install: install_dotfiles install_env

install_dotfiles:
	@$(foreach FILE, $(FILES), ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;)
	@$(foreach FILE, $(EMPTIES), touch ~/.$(FILE) ;)
	@mkdir -p ~/.zsh_cache

HOMEBREW = readline bcrypt \
		   ack curl nmap \
		   node python pypy rbenv ruby-build \
		   postgresql redis \
		   hub tig \
		   tmux reattach-to-user-namespace \
		   mercurial vim
HB_TO_INSTALL = $(filter-out $(shell brew list), $(HOMEBREW))

#GEMS =
# other gems should be installed via Gemfile

NPM_PKGS = coffee-script jwalk

install_env:
	@brew update
	@$(foreach PKG, $(HB_TO_INSTALL), brew install $(PKG) ;)
	@rbenv install 1.9.3-p194
	@rbenv default 1.9.3-p194
	#@$(foreach GEM, $(GEMS), gem install $(GEM); )
	@$(foreach NM, $(NPM_PGKS), npm install $(NM) ;)

.PHONY: install install_dotfiles install_brew_packs install_lang
