;;; config --- Summary

;;; Commentary:

;;; Code:

(auto-save-mode 1)

(load! "+magit")
(load! "+lisp")
(load! "+org")
(load! "+prodigy")
(load! "+ranger")
(load! "+ui")

(def-package! feature-mode
  :defer t
  :config
  (setq feature-step-search-path "features/**/*steps.rb"))


(after! projectile
  (projectile-add-known-project "~/projects/dotfiles")
  (projectile-add-known-project "~/projects/emacs/doom-emacs")
  (projectile-add-known-project "~/projects/emacs/emacs-doom-themes"))

(load "~/local.el" 'noerror 'nomessage)
