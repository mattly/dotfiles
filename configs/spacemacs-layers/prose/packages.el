(defvar prose-packages '(;; major modes
                         fountain-mode
                         pandoc-mode

                         ;; minor modes
                         cm-mode
                         olivetti
                         writeroom-mode))

(defvar prose-excluded-packages '())

(defun prose/init-fountain-mode ()
  (use-package fountain-mode
    :defer t
    :config
    (progn
      (evil-leader/set-key-for-mode 'fountain-mode
        "ma" 'fountain-beginning-of-scene
        "mb" 'fountain-outline-backward
        "me" 'fountain-end-of-scene
        "mf" 'fountain-outline-forward
        "mn" 'fountain-outline-next
        "mp" 'fountain-outline-previous
        "ms" 'fountain-forward-scene))
    :mode (("\\.fountain\\'" . fountain-mode))
    ))

(defun prose/init-pandoc-mode ()
  (use-package pandoc-mode
    :defer t))

(defun prose/init-cm-mode ()
  (use-package cm-mode
    :defer t))

;; disabled pending fix for guide-key
(defun prose/init-olivetti ()
  (use-package olivetti
    :defer t))

(defun prose/init-writeroom-mode ()
  (use-package writeroom-mode
    :defer t
    :init
    (progn
      (evil-leader/set-key
        "tW" 'writeroom-mode))))



