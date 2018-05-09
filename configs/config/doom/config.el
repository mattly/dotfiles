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
