(defvar mattly-packages '(js-doc
                          jsx-mode
                          nodejs-repl
                          om-mode

                          pcmpl-args
                          pcomplete-extension
                          pcmpl-homebrew
                          pcmpl-git

                          wordsmith-mode
                          osx-dictionary

                          farmhouse-theme))

(defvar mattly-excluded-packages '())

(dolist (pkg mattly-packages)
  (eval `(defun ,(intern (format "mattly/init-%s" pkg)) nil)))
