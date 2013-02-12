IGNORE = Readme.md Makefile .git .gitignore install
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env

ready:
	@open https://github.com/kennethreitz/osx-gcc-installer
	@open https://code.google.com/p/iterm2/downloads/list

install: install_dotfiles install_vundle install_env

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

vim/bundle/vundle:
	@mkdir -p vim/bundle
	@git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

install_env:
	@vim +BundleInstall +qall
	@brew update
	@$(foreach PKG, $(HB_TO_INSTALL), brew install $(PKG) ;)
	@rbenv install 1.9.3-p385
	@rbenv global 1.9.3-p385
	#@$(foreach GEM, $(GEMS), gem install $(GEM); )
	@$(foreach NM, $(NPM_PGKS), npm install $(NM) ;)

.PHONY: install install_dotfiles install_brew_packs install_env ready
