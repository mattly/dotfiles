;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 14)
      doom-font (font-spec :family "IBM Plex Mono" :size 14 :weight 'light)
      doom-big-font (font-spec :family "IBM Plex Mono" :size 18 :weight 'light))

;; left over from fira code, which has different widths between bold and not
;; (set-face-attribute 'show-paren-match nil :weight mono-font-weight)

(setq-default line-spacing 0.12)
(add-hook 'magit-revision-mode-hook (lambda () (setq line-spacing 0)))


;; set neotree so open chevrons are same width as closed ones
(setq doom-neotree-chevron-size 0.7
      doom-neotree-file-icons t)

;; theme
(setq doom-theme
      ;; -- darker
      ;; 'doom-one
      'doom-dracula
      ;; 'doom-molokai
      ;; 'doom-peacock
      ;; 'doom-vibrant
      ;; -- lighter
      ;; 'doom-one-light
      ;; 'doom-alabaster
      doom-dracula-brighter-comments t
      doom-dracula-brighter-modeline t
      doom-dracula-colorful-headers t
      doom-dracula-comment-bg nil
      doom-dracula-padded-modeline nil
      doom-one-light-brighter-modeline t
      doom-one-light-brighter-comments t
      doom-one-light-comment-bg nil
      doom-molokai-brighter-comments t
      doom-peacock-brighter-comments t
      doom-peacock-comment-bg nil
      doom-peacock-brighter-modeline t
      doom-themes-padded-modeline nil)

;; etc
(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order))
      which-key-idle-delay 0.3)

(default-text-scale-mode)

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
  (parinfer " " major-mode flycheck))
