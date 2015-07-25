{:user {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "1.1.0"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.10"]
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [org.clojure/tools.namespace "0.2.4"]
                       [leiningen #=(leiningen.core.main/leiningen-version)]
                       [io.aviso/pretty "0.1.8"]
                       [im.chit/vinyasa "0.3.4"]
                       [spyscope "0.1.5"]
                       [difform "1.1.2"]]
        :injections [(require 'spyscope.core)
                     (require '[vinyasa.inject :as inject])
                     (require 'alex-and-georges.debug-repl)
                     (inject/in [vinyasa.inject :refer [inject [in inject-in]]]
                                [vinyasa.lein :exclude [*project*]]
                                [vinyasa.pull :all]

                                ;; inject into clojure.core
                                clojure.core
                                [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                                ;; inject into clojure.core with prefix
                                clojure.core >
                                [clojure.repl doc source]
                                [clojure.pprint pprint pp]
                                [clojure.java.shell sh]
                                [alex-and-georges.debug-repl debug-repl]
                                [com.georgejahad.difform difform]
                                )]}}
