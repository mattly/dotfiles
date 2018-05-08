;;; -*- lexical-binding: t; -*-

;; fonts
(setq  doom-font (font-spec :family "Iosevka Light" :size 15)
       doom-big-font (font-spec :family "Iosevka" :size 21)
       doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;; theme
(setq  doom-peacock-brighter-comments t
       doom-peacock-comment-bg nil
       doom-peacock-brighter-modeline t
       doom-theme 'doom-peacock)

;; default frame
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 110))
(set-frame-parameter (selected-frame) 'alpha '(97 . 95))

;; set ligatures on railwaycat
(when (boundp mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

;; modeline
(def-modeline! main
  (bar matches " " buffer-info)
  (parinfer " " major-mode vcs flycheck))
