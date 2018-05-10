;;; config --- Summary

;;; Commentary:

;;; Code:

(auto-save-mode 1)

;; magit
(def-package! magit
  :config
  (setq-default git-magit-status-fullscreen t)
  (setq magit-repository-directories '("projects")))


(load! +lisp)
(load! +ui)

(def-package! feature-mode
  :config
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
  (setq feature-step-search-path "features/**/*steps.rb"))
