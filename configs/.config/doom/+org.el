;;; ~/projects/dotfiles/configs/.config/doom/+org.el -*- lexical-binding: t; -*-

(after! org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t))))
