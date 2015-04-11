(defvar mattly-packages '(js-doc
                          jsx-mode
                          nodejs-repl
                          om-mode

                          farmhouse-theme))

(defvar mattly-excluded-packages '())

(dolist (pkg mattly-packages)
  (eval `(defun ,(intern (format "mattly/init-%s" pkg)) nil)))
