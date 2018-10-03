;;; -*- lexical-binding: t; -*-

;; fonts
(setq text-scale-mode-step 1.05
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 15 :weight 'medium)
      doom-font (font-spec :family "IBM Plex Mono" :size 15 :weight 'medium)
      doom-big-font (font-spec :family "IBM Plex Mono" :size 21 :weight 'light)
      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-neotree-file-icons t
      doom-neotree-enable-variable-pitch t
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


(defun define-treemacs-icon (icon-def)
  (let* ((icon-spec (car icon-def))
         (icon-family (car icon-spec))
         (icon-name (car (cdr icon-spec)))
         (icon-args (cdr (cdr icon-spec))))
    (apply 'treemacs-define-custom-icon
           (apply icon-family icon-name icon-args)
           (cdr icon-def))))

(after! treemacs
  :config
  ;; (treemacs-resize-icons 18)
  (setq treemacs-fringe-indicator-mode t
        treemacs-indentation 1
        treemacs-space-between-root-nodes nil
        treemacs-width 25

        treemacs-icon-root-png
        (concat (all-the-icons-octicon "repo" :v-adjust -0.1 :height 1.6 :face 'font-lock-string-face) " ")
        treemacs-icon-open-png
        (concat (all-the-icons-octicon "file-directory" :height 1.1 :v-adjust 0) " ")
        treemacs-icon-closed-png
        (concat (all-the-icons-octicon "file-directory" :height 1.1 :v-adjust 0 :face 'all-the-icons-silver) " ")
        treemacs-icon-fallback
        (concat (all-the-icons-octicon "file-code" :height 1) " ")
        treemacs-icon-text treemacs-icon-fallback)

  (mapc
   #'define-treemacs-icon
   '(
     ((all-the-icons-fileicon "apple" :v-adjust 0.0 :height 1.0)
      "m" "mm")

     ((all-the-icons-faicon "beer" :face all-the-icons-silver)
      "Brewfile")
     ((all-the-icons-octicon "book" :height 1.0 :v-adjust 0.0 :face all-the-icons-silver)
      "license" "todo" "readme")
     ((all-the-icons-octicon "bug" :face all-the-icons-maroon)
      "log")

     ((all-the-icons-alltheicon "c-line" :face all-the-icons-blue)
      "c" "h")
     ((all-the-icons-fileicon "cljs" :face all-the-icons-dblue :height 1.0)
      "cljs")
     ((all-the-icons-alltheicon "clojure" :face all-the-icons-blue :height 1.0)
      "clj" "cljc" "edn" "joker" "joke" "boot" "lein-repl-history" "lein-failures" "nrepl-port")
     ((all-the-icons-faicon "cloud" :face all-the-icons-lblue)
      "Capstanfile")
     ((all-the-icons-faicon "cogs" :face all-the-icons-silver)
      "DS_Store" "dll" "dmg" "pid")
     ((all-the-icons-alltheicon "css3" :face all-the-icons-yellow)
      "css")
     ((all-the-icons-fileicon "cucumber" :face all-the-icons-green)
      "feature")

     ((all-the-icons-fileicon "dockerfile" :face all-the-icons-lblue)
      "Dockerfile" "dockerignore")

     ((all-the-icons-fileicon "editorconfig" :face all-the-icons-blue)
      "editorconfig")
     ((all-the-icons-fileicon "elisp" :face all-the-icons-purple :height 1.0 :v-adjust -0.2)
      "el")

     ((all-the-icons-octicon "file-binary" :v-adjust 0.0 :face all-the-icons-dsilver)
      "elc")
     ((all-the-icons-octicon "file-media" :v-adjust 0.0 :face all-the-icons-dblue)
      "ico" "png" "gif" "jpg" "jpeg" "svg")
     ((all-the-icons-octicon "file-pdf" :face :all-the-icons-dred)
      "pdf")
     ((all-the-icons-octicon "file-text" :face all-the-icons-cyan)
      "txt" "text")
     ((all-the-icons-octicon "file-zip" :v-adjust 0.0 :face all-the-icons-lmaroon)
      "gz" "zip" "7z" "rar" "tar")
     ((all-the-icons-faicon "film" :face all-the-icons dblue)
      "mov" "mp4" "ogv")
     ((all-the-icons-fileicon "font" :v-adjust 0.0 :face all-the-icons-cyan)
      "ttf" "woff" "woff2" "otf")


     ((all-the-icons-alltheicon "git" :face all-the-icons-red :v-adjust 0.0)
      "gitconfig" "gitignore" "git")
     ((all-the-icons-fileicon "gnu" :face all-the-icons-dorange)
      "Makefile" "mk")
     ((all-the-icons-fileicon "graphql" :face all-the-icons-purple)
      "graphql" "graphqlconfig" "graphqlrc")

     ((all-the-icons-alltheicon "html5" :face all-the-icons-orange)
      "html" "html5" "htm")

     ((all-the-icons-alltheicon "javascript" :face all-the-icons-yellow :height 1.0 :v-adjust 0.0)
      "js" "es6" "es7")
     ((all-the-icons-fileicon "jsx-2" :face all-the-icons-ccyan-alt :height 1.0 :v-adjust -0.1)
      "jsx")

     ((all-the-icons-octicon "key" :height 1.0 :v-adjust 0.0 :face all-the-icons-orange)
      "crt" "gpg" "key" "p12" "pem" "pub")

     ((all-the-icons-alltheicon "less" :height 0.8 :face all-the-icons-dyellow)
      "less")
     ((all-the-icons-octicon "lock" :face all-the-icons-maroon)
      "lock")
     ((all-the-icons-fileicon "lua" :face all-the-icons-blue :v-adjust 0.0)
      "lua")

     ((all-the-icons-octicon "markdown" :face all-the-icons-blue :v-adjust 0.0)
      "md" "markdown")

     ((all-the-icons-fileicon "npm" :face all-the-icons-dred)
      "npmignore" "npmrc")

     ((all-the-icons-fileicon "postcss" :face all-the-icons-dred)
      "postcss" "sss")

     ((all-the-icons-octicon "ruby" :face all-the-icons-lred :v-adjust 0.0)
      "rb")
     ((all-the-icons-alltheicon "ruby-alt" :face all-the-icons-red)
      "gem" "Gemfile" "ruby-gemset" "ruby-version")

     ((all-the-icons-alltheicon "sass" :face all-the-icons-pink)
      "scss" "sass")
     ((all-the-icons-octicon "settings" :face all-the-icons-blue :v-adjust 0.0)
      "conf" "config" "cson" "ini" "itermcolors" "json" "properties" "toml" "xml" "yaml" "yml")
     ((all-the-icons-fileicon "stylelint" :v-adjust 0.0 :face all-the-icons-dblue)
      "stylelint")
     ((all-the-icons-alltheicon "stylus" :face all-the-icons-lgreen)
      "styl")

     ((all-the-icons-alltheicon "terminal" :face all-the-icons-lcyan)
      "fish" "zsh" "sh")
     ((all-the-icons-fileicon "typescript" :face all-the-icons-blue-alt :height 1.0 :v-adjust -0.1)
      "ts" "tsx"))))


;; etc
(after! ivy
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order))
        which-key-idle-delay 0.3))

(default-text-scale-mode)

;; default frame
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 120))
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
;; (set-frame-parameter (selected-frame) 'alpha '(99 . 97))

;; set ligatures on railwaycat
;; (when (boundp mac-auto-operator-composition-mode)
;;   (mac-auto-operator-composition-mode))


;; modeline
(setq icon-modes '((gfm-mode . markdown-mode)))

(def-modeline-segment! modeicon
  (concat
   (let ((icon (all-the-icons-icon-for-buffer)))
     (unless (symbolp icon)
       (propertize icon
                   'display '(raise -0.1)
                   'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer) :inherit))))
   " "))


(def-modeline! 'main
  '(bar matches " " buffer-info)
  '(+parinfer " " modeicon major-mode flycheck))
