;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 15 :weight 'medium)
      doom-font (font-spec :family "IBM Plex Mono" :size 15 :weight 'light)
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
(setq doom-theme
      'doom-outrun
      doom-outrun-brighter-comments nil
      doom-outrun-comment-bg nil
      doom-themes-padded-modeline nil)


(after! treemacs
  :config
  (setq treemacs-fringe-indicator-mode t
        treemacs-indentation 1
        treemacs-space-between-root-nodes nil
        treemacs-width 25)
  (comment
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
       (set-face-attribute face nil :inherit `(variable-pitch ,@(delq 'unspecified (doom-enlist faces))))))))


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
(def-modeline! 'main
  '(bar matches " " buffer-info)
  '(+parinfer " " major-mode flycheck))
