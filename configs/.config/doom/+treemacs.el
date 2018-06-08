;;; ~/mattly/dotfiles/configs/config/doom/+treemacs.el -*- lexical-binding: t; -*-

(def-package! treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t))

(def-package! treemacs-evil
  :after treemacs evil)

(def-package! treemacs-projectile
  :after treemacs projectile)
