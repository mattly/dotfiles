;;; ~/projects/dotfiles/configs/.config/doom/+prodigy.el -*- lexical-binding: t; -*-

;; https://github.com/rejeep/prodigy.el

(after! prodigy
  :config

  (prodigy-define-service
    :name "mountebank"
    :command "mb"
    :tags '(work test server)))
