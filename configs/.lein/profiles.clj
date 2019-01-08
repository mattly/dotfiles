{:user {:plugins [[cider/cider-nrepl "0.20.0-SNAPSHOT"]
                  #_[lein-figwheel "0.5.19-SNAPSHOT"]]
        :dependencies [#_[cider/piggieback "0.3.10"]
                       [nrepl "0.5.3"]
                       #_[figwheel-sidecar "0.5.19-SNAPSHOT"]]
        :repl-options {:nrepl-middleware [#_cider.piggieback/wrap-cljs-repl]}}}
