;;; -*- lexical-binding: t; -*-

(def-package! evil-cleverparens
  :hook ((smartparens-enabled) . evil-cleverparens-mode)
  :config (setq evil-cleverparens-swap-move-by-word-and-symbol t))
  ;; (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode))

(def-package! parinfer
  :init
  (setq parinfer-auto-switch-indent-mode t
        parinfer-auto-switch-indent-mode-when-closing t))

(def-modeline-segment! parinfer
  (if (bound-and-true-p parinfer-mode)
      (if (eq parinfer--mode 'indent)
          ">" ")")))

(def-package! flycheck-joker)

(def-package! cider
  :config
  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion))
