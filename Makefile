IGNORE = Readme.md Makefile .git .gitignore
FILES = $(filter-out $(IGNORE), $(wildcard *))
EMPTIES = env

install:
	@$(foreach FILE, $(FILES), \
		ln -sf $(shell pwd)/$(FILE) ~/.$(FILE) ;\
	 )
	@$(foreach FILE, $(EMPTIES), \
		touch ~/.$(FILE) ;\
	 )
	@mkdir -p ~/.zsh_cache

.PHONY: install
