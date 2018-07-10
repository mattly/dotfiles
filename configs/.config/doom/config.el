;;; config --- Summary

;;; Commentary:

;;; Code:

(auto-save-mode 1)

;; magit
(after! magit
  :config
  (setq-default git-magit-status-fullscreen t)
  (setq magit-log-section-commit-count 20
        magit-repository-directories '(("~/projects" . 1))))


(load! "+lisp")
(load! "+org")
(load! "+prodigy")
(load! "+ui")

(def-package! feature-mode
  :defer t
  :config
  (setq feature-step-search-path "features/**/*steps.rb"))


(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

;; (map-put hs-special-modes-alist
;;          'yaml-mode
;;          '("\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))

;; (map-put hs-special-modes-alist
;;          'ruby-mode
;;          '("\\(class\\|module\\|def\\|do\\|{\\)" "\\(end\\|}\\)" "#"
;;            (lambda (arg) (ruby-end-of-block)) nil))
