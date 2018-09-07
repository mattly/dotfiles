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

(load "~/local.el" 'noerror 'nomessage)
