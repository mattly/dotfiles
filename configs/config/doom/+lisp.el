;;; -*- lexical-binding: t; -*-

(def-package! evil-cleverparens
  :config (setq evil-cleverparens-swap-move-by-word-and-symbol t)
  (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode))

(def-package! parinfer
  :config
  (setq parinfer-extensions
        '(defaults
           evil
           pretty-parents
           smart-tab
           smart-yank)
        parinfer-auto-switch-indent-mode t
        parinfer-auto-switch-indent-mode-when-closing t)
  (add-hook! (clojure-mode
              emacs-lisp-mode
              common-lisp-mode
              scheme-mode
              lisp-mode)
    #'parinfer-mode))

(def-modeline-segment! parinfer
  (if (bound-and-true-p parinfer-mode)
      (if (eq parinfer--mode 'indent)
          ">" ")")))

(map! :map parinfer-mode-map
      [tab] #'parinfer-smart-tab:forward-char
      [backtab] #'parinfer-smart-tab:backward-char
      :localleader
      :desc "toggle parinfer mode" :nv "m" #'parinfer-toggle-mode)

(def-package! flycheck-joker)

(def-package! cider
  :config
  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion))