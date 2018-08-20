;;; doom-outrun-theme.el --- inspired by VSCode Outrun
(require 'doom-themes)

;;
(defgroup doom-outrun-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-outrun-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-outrun-theme
  :type 'boolean)

(defcustom doom-outrun-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-outrun-theme
  :type 'boolean)

(defcustom doom-outrun-comment-bg nil
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-outrun-theme
  :type 'boolean)

(defcustom doom-outrun-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-outrun-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-outrun
  "A dark theme inspired by outruntheme.com"

  ;; name        default   256       16
  ((bg         '("#080715" nil       nil))
   (bg-alt     '("#0c0a20" nil       nil))
   (base0      '("#212020" "black"   "black"))
   (base1      '("#393838" "#3a3a3a" "brightblack"))
   (base2      '("#484f7d" "#585858" "brightblack"))
   (base3      '("#696866" "#6c6c6c" "brightblack"))
   (base4      '("#81807e" "#808080" "brightblack"))
   (base5      '("#989895" "#949494" "brightblack"))
   (base6      '("#b0b0ac" "#b2b2b2" "brightblack"))
   (base7      '("#c8c8c3" "#c6c6c6" "brightblack"))
   (base8      '("#e0e0db" "#dadada" "white"))
   (fg-alt     '("#f1f2fa" "#eeeeee" "brightwhite"))
   (fg         '("#f8f8f2" nil "white"))

   (grey       base4)
   (red        '("#ff0081" "#ff0087" "red"))
   (orange     '("#ff9850" "#ff875f" "brightred"))
   (green      '("#a6ee21" "#afd7d7" "green"))
   (teal       '("#66ff99" "#5fff87" "brightgreen"))
   (yellow     '("#f4b80c" "#ffd700" "yellow"))
   (blue       '("#42c6ff" "#5fafff" "brightblue"))
   (dark-blue  '("#456b7c" "#5f5f87" "blue"))
   (magenta    '("#ff2afc" "#ff5fff" "magenta"))
   (violet     '("#ee44dd" "#ff87af" "brightmagenta"))
   (cyan       '("#66ffff" "#5fffff" "brightcyan"))
   (dark-cyan  '("#44c6aa" "#00ffaf" "cyan"))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.5))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-outrun-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-outrun-brighter-comments dark-cyan base5) 0.25))
   (constants      fg-alt)
   (functions      base8)
   (keywords       violet)
   (methods        orange)
   (operators      blue)
   (type           red)
   (strings        green)
   (variables      base8)
   (numbers        yellow)
   (region         base2)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-outrun-brighter-modeline)
   (-modeline-pad
    (when doom-outrun-padded-modeline
      (if (integerp doom-outrun-padded-modeline) doom-city-lights-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-outrun-comment-bg (doom-lighten bg 0.05))
    :slant 'italic)
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (font-lock-keyword-face
    :foreground keywords
    :slant 'italic)

   (font-lock-function-name-face
    :foreground functions
    :weight 'bold)

   (highlight-quoted-symbol
    :foreground type
    :weight 'bold)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-url-face    :foreground teal :weight 'normal)
   (markdown-reference-face :foreground base6)
   ((markdown-bold-face &override)   :foreground fg)
   ((markdown-italic-face &override) :foreground fg-alt)

   ;; outline (affects org-mode)
   ((outline-1 &override) :foreground blue)
   ((outline-2 &override) :foreground green)
   ((outline-3 &override) :foreground teal)
   ((outline-4 &override) :foreground (doom-darken blue 0.2))
   ((outline-5 &override) :foreground (doom-darken green 0.2))
   ((outline-6 &override) :foreground (doom-darken teal 0.2))
   ((outline-7 &override) :foreground (doom-darken blue 0.4))
   ((outline-8 &override) :foreground (doom-darken green 0.4))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (solaire-org-hide-face :foreground hidden)))


  ;; --- extra variables ---------------------
  ;; ()


;;; doom-outrun-theme.el ends here
