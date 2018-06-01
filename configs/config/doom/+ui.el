;;; -*- lexical-binding: t; -*-

;; fonts
(setq doom-font (font-spec :family "Iosevka" :weight 'light :size 15)
      doom-big-font (font-spec :family "Iosevka" :size 20)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 15)
      text-scale-mode-step 1.05)

(setq-default line-spacing 0.1)
(add-hook 'magit-revision-mode-hook (lambda () (setq line-spacing 0)))

;; set neotree so open chevrons are same width as closed ones
(setq doom-neotree-chevron-size 0.7
      doom-neotree-file-icons t)

;; theme
(setq doom-theme
      ;; -- darker
      ;; 'doom-one
      ;; 'doom-peacock
      ;; -- lighter
      'doom-one-light
      ;; 'doom-alabaster
      doom-one-light-brighter-modeline t
      doom-one-light-brighter-comments t
      doom-one-light-comment-bg nil
      doom-peacock-brighter-comments t
      doom-peacock-comment-bg nil
      doom-peacock-brighter-modeline t
      doom-themes-padded-modeline nil)

;; etc
(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order))
      which-key-idle-delay 0.3)

;; default frame
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 200))
;; (set-frame-parameter (selected-frame) 'alpha '(99 . 97))

;; set ligatures on railwaycat
(when (boundp mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

;; modeline
(def-modeline! main
  (bar matches " " buffer-info)
  (parinfer " " major-mode vcs flycheck))
