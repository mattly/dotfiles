{:user {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "1.1.0"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.10"]
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [im.chit/vinyasa "0.3.4"]
                       [spyscope "0.1.5"]
                       [difform "1.1.2"]
                       [clj-ns-browser "1.4.0-SNAPSHOT"]]
        :injections [(require 'vinyasa.inject)
                     (require 'alex-and-georges.debug-repl)
                     (vinyasa.inject/inject 'clojure.core '>
                                            '[[clojure.repl doc source]
                                              [clojure.pprint pprint pp]
                                              [alex-and-georges.debug-repl debug-repl]
                                              [com.georgejahad.difform difform]
                                              [clj-ns-browser.sdoc sdoc]])]}}
