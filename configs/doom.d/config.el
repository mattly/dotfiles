;;; config --- Summary

;;; Commentary:

;;; Code:

(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 110))
(set-frame-parameter (selected-frame) 'alpha '(97 . 95))

;; set ligatures on railwaycat
(when (boundp mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

(auto-save-mode 1)

(setq magit-repository-directories '("projects"))

(defvar mattly-lisp-mode-map (make-sparse-keymap))

(define-minor-mode mattly-lisp-mode
  :init-val nil
  :key-map mattly-lisp-mode-map
  (parinfer-mode 1))

(add-hook 'clojure-mode-hook #'mattly-lisp-mode)
(add-hook 'emacs-lisp-mode-hook #'mattly-lisp-mode)

(def-package! parinfer
  :init
  (progn
    (setq parinfer-extensions
          '(defaults
             pretty-parents
             evil
             smart-tab
             smart-yank))))

(def-package! evil-cleverparens
  :config
  (setq evil-cleverparens-swap-move-by-word-and-symbol t)
  (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode))

(def-modeline-segment! parinfer
  (if (bound-and-true-p parinfer-mode)
      (if (eq parinfer--mode 'indent)
          ">" ")")))

(def-modeline! main
  (bar matches " " buffer-info)
  (parinfer " " major-mode vcs flycheck))

(map! :map mattly-lisp-mode-map
      :desc "Slurp Forwward" "C-'" #'sp-forward-slurp-sexp
      :desc "Slurp Backward" "C-;" #'sp-backward-slurp-sexp
      :desc "Barf Forward" "C-\"" #'sp-forward-barf-sexp
      :desc "Barf Backward" "C-:" #'sp-backward-barf-sexp
      :desc "Toggle Paredit" "C-," #'parinfer-toggle-mode
      :desc "Indent to next level" [tab] #'parinfer-smart-tab:forward-char
      :desc "Deindent to prev" [backtab] #'parinfer-smart-tab:backward-char)
