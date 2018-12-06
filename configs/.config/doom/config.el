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

(map!
 :desc "previous word" :nvi "<A-left>" 'evil-backward-word-begin
 :desc "previous WORD" :nvi "<M-A-left>" 'evil-backward-WORD-begin
 :desc "forward word"  :nvi "<A-right>" 'evil-forward-word-end
 :desc "forward WORD"  :nvi "<M-A-right>" 'evil-forward-WORD-end)


(after! projectile
  (projectile-add-known-project "~/projects/dotfiles")
  (projectile-add-known-project "~/projects/emacs/doom-emacs")
  (projectile-add-known-project "~/projects/emacs/emacs-doom-themes"))

(load "~/local.el" 'noerror 'nomessage)

(setenv "EDITOR" "emacsclient")
