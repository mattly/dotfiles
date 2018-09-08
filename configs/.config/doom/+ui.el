;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 15 :weight 'medium)
      doom-font (font-spec :family "IBM Plex Mono" :size 15 :weight 'medium)
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
      doom-outrun-brighter-modeline t
      doom-themes-padded-modeline nil
      doom-treemacs-use-generic-icons nil)

(when IS-MAC
  (setq mac-mouse-wheel-smooth-scroll t))


(defvar icon/height 1)

(defun icons/define (icon exts)
  (apply 'treemacs-define-custom-icon icon exts))

(defun icons/ati (icon face &rest exts)
  (icons/define (all-the-icons-alltheicon icon :height icon/height :face face) exts))

(defun icons/file (icon face &rest exts)
  (icons/define (all-the-icons-fileicon icon :height icon/height :face face) exts))

(defun icons/fai (icon face &rest exts)
  (icons/define (all-the-icons-faicon icon :height icon/height :face face) exts))

(defun icons/oct (icon face &rest exts)
  (icons/define (all-the-icons-octicon icon :height icon/height :face face) exts))

(after! treemacs
  :config
  (setq treemacs-fringe-indicator-mode t
        treemacs-indentation 1
        treemacs-space-between-root-nodes nil
        treemacs-width 25)
  (treemacs-resize-icons 18)
  (setq treemacs-icon-open-png
        (concat (all-the-icons-octicon "file-directory" :height 1.1 :v-adjust 0) " ")
        treemacs-icon-closed-png
        (concat (all-the-icons-octicon "file-directory" :height 1.1 :v-adjust 0 :face 'all-the-icons-silver) " ")
        treemacs-icon-fallback
        (concat (all-the-icons-octicon "file-code" :height 1) " ")
        treemacs-icon-text treemacs-icon-fallback)
  (icons/fai "beer" 'all-the-icons-blue "Brewfile")
  (icons/ati "clojure" 'all-the-icons-green "clj" "cljc" "edn" "joker" "joke")
  (icons/file "cljs" 'all-the-icons-blue "cljs")
  (icons/file "editorconfig" 'all-the-icons-cyan "editorconfig")
  (icons/file "elisp" 'all-the-icons-blue "el")
  (icons/ati "git" 'all-the-icons-red "gitconfig" "gitignore" "git")
  (icons/ati "javascript" 'all-the-icons-yellow "js" "es6")
  (icons/file "jsx-2" 'all-the-icons-cyan "jsx" "tsx")
  (icons/file "lua" 'all-the-icons-blue "lua")
  (icons/oct "markdown" 'all-the-icons-silver "md" "markdown")
  (icons/file "npm" 'all-the-icons-red "package.json" "package.lock.json" "yarn.lock" "npmignore")
  (icons/oct "settings" 'all-the-icons-blue "config" "cson" "ini" "json" "toml" "yaml" "yml")
  (icons/ati "terminal" 'all-the-icons-green "fish" "zsh" "sh")
  (icons/file "typescript" 'all-the-icons-cyan "ts"))




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
