;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 16 :weight 'bold)
      doom-font (font-spec :family "IBM Plex Mono" :size 16 :weight 'light)
      doom-big-font (font-spec :family "IBM Plex Mono" :size 21 :weight 'light)
      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-treemacs-enable-variable-pitch t)

;; (setq-default line-spacing 0.12)
(add-hook 'magit-revision-mode-hook (lambda () (setq line-spacing 0)))


;; set neotree so open chevrons are same width as closed ones
(setq doom-neotree-chevron-size 0.7
      doom-neotree-file-icons t)


;; theme
;; (setq doom-theme
;;       ;; -- darker
;;       ;; 'doom-one
;;       'doom-dracula
;;       ;; 'doom-molokai
;;       ;; 'doom-peacock
;;       ;; 'doom-vibrant
;;       ;; -- lighter
;;       ;; 'doom-one-light
;;       ;; 'doom-alabaster
;;       doom-challenger-deep-brighter-comments t
;;       doom-challenger-deep-brighter-modeline t
;;       doom-challenger-deep-padded-modeline nil
;;       doom-dracula-brighter-comments t
;;       doom-dracula-brighter-modeline t
;;       doom-dracula-colorful-headers t
;;       doom-dracula-comment-bg nil
;;       doom-dracula-padded-modeline nil
;;       doom-one-light-brighter-modeline t
;;       doom-one-light-brighter-comments t
;;       doom-one-light-comment-bg nil
;;       doom-molokai-brighter-comments t
;;       doom-peacock-brighter-comments t
;;       doom-peacock-comment-bg nil
;;       doom-peacock-brighter-modeline t
;;       doom-themes-padded-modeline nil)


(setq kaolin-themes-bold t
      kaolin-themes-italic t
      kaolin-themes-underline t
      kaolin-themes-underline-wave t
      kaolin-themes-hl-line-colored t
      kaolin-themes-italic-comments t
      kaolin-themes-comments-style 'color
      kaolin-themes-git-gutter-solid t
      kaolin-themes-distinct-fringe t
      kaolin-themes-distinct-company-scrollbar t
      kaolin-themes-boolean t)


(after! treemacs
  :config
  (setq treemacs-fringe-indicator-mode t
        treemacs-indentation 1
        treemacs-space-between-root-nodes nil)
  (dolist (face '(treemacs-root-face
                  treemacs-git-unmodified-face
                  treemacs-git-modified-face
                  treemacs-git-ignored-face
                  treemacs-git-untracked-face
                  treemacs-git-added-face
                  treemacs-git-conflict-face
                  treemacs-directory-face
                  treemacs-directory-collapsed-face
                  treemacs-file-face))
    (let ((faces (face-attribute face :inherit nil)))
      (set-face-attribute face nil :inherit `(variable-pitch ,@(delq 'unspecified (doom-enlist faces)))))))


(load-theme 'kaolin-valley-dark)

;; etc
(after! ivy
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order))
        which-key-idle-delay 0.3))

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
  (+parinfer " " major-mode flycheck))
