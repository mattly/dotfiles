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


;; (defun +data-hideshow-forward-sexp (arg)
;;   (let ((start (current-indentation)))
;;     (forward-line)
;;     (unless (= start (current-indentation))
;;       (require 'evil-indent-plus)
;;       (let ((range (evil-indent-plus--same-indent-range)))
;;         (goto-char (cadr range))
;;         (end-of-line)))))

;; (map-put hs-special-modes-alist
;;          'yaml-mode
;;          '("\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))

;; (map-put hs-special-modes-alist
;;          'ruby-mode
;;          '("\\(class\\|module\\|def\\|do\\|{\\)" "\\(end\\|}\\)" "#"
;;            (lambda (arg) (ruby-end-of-block)) nil))
