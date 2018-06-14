;;; config --- Summary

;;; Commentary:

;;; Code:

(auto-save-mode 1)

;; magit
(after! magit
  :config
  (setq-default git-magit-status-fullscreen t)
  (setq magit-repository-directories '(("~/projects" . 1))))


(load! "+lisp")
(load! "+ui")

(def-package! feature-mode
  :defer t
  :config
  (setq feature-step-search-path "features/**/*steps.rb"))
