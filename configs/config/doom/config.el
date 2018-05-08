;;; config --- Summary

;;; Commentary:

;;; Code:
;; (def-package-hook! emacs-snippets :disabled t)

(auto-save-mode 1)

;; magit
(setq magit-repository-directories '("projects"))



(load! +lisp)
(load! +ui)
