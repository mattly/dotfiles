;;; ~/projects/dotfiles/configs/.config/doom/+magit.el -*- lexical-binding: t; -*-

(setq +magit-hub-features nil
      +magit-hub-enable-by-default nil)

(after! magit
  :config
  (setq-default git-magit-status-fullscreen t)
  (setq magit-log-section-commit-count 20
        magit-save-repository-buffers 'dontask
        magit-popup-display-buffer-action nil
        magit-display-file-buffer-function #'switch-to-other-buffer-window
        magit-repository-directories '(("~/projects" . 1))))


