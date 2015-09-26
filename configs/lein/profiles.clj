{:user {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "1.1.0"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.10"]
                       #_[org.clojars.gjahad/debug-repl "0.3.3"]
                       #_[org.clojure/tools.namespace "0.2.4"]
                       #_[leiningen #=(leiningen.core.main/leiningen-version)]
                       #_[io.aviso/pretty "0.1.8"]
                       #_[im.chit/vinyasa "0.3.4" :exclude [clj-http]]
                       #_[spyscope "0.1.5"]
                       #_[difform "1.1.2"]]
        #_:injections #_[(require 'spyscope.core)
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
