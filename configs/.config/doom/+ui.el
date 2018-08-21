;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 15 :weight 'medium)
      doom-font (font-spec :family "IBM Plex Mono" :size 15 :weight 'light)
      doom-big-font (font-spec :family "IBM Plex Mono" :size 21 :weight 'light)
      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-treemacs-enable-variable-pitch t)

(setq-default line-spacing 0.1)
(add-hook 'magit-revision-mode-hook (lambda () (setq line-spacing 0)))


;; theme
(setq doom-theme
      'doom-outrun
      doom-outrun-brighter-comments nil
      doom-outrun-comment-bg nil
      doom-themes-padded-modeline nil)

(when IS-MAC
  (setq mac-mouse-wheel-smooth-scroll t))

(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)

(after! treemacs
  :config
  (setq ;treemacs-fringe-indicator-mode t
        treemacs-indentation 1
        treemacs-space-between-root-nodes nil
        treemacs-width 25))


;; etc
(after! ivy
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order))
        which-key-idle-delay 0.3))

(default-text-scale-mode)

;; default frame
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 100))
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
;; (set-frame-parameter (selected-frame) 'alpha '(99 . 97))

;; set ligatures on railwaycat
(when (boundp mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

;; modeline
(def-modeline! 'main
  '(bar matches " " buffer-info)
  '(+parinfer " " major-mode flycheck))
