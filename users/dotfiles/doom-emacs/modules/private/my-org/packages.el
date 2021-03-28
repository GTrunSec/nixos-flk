(package! org-starter)

(package! org-superstar)

(package! org-ql :recipe (:host github :repo "alphapapa/org-ql"
                         :files ("*.el")
                         ))

(package! helm-org-rifle)

(package! org-books :recipe (:host github :repo "lepisma/org-books"))

(package! org-z :recipe (:host github :repo "landakram/org-z"
                         :files ("*.el")
                         ))

(package! org-super-agenda)

(package! org-edna :recipe (:build (:not compile)))

(package! org-wild-notifier)

(package! notdeft :recipe (:host github :repo "hasu/notdeft"))

(unpin! org-roam)

;;(package! org-roam-server)

;;(package! org-roam-bibtex)

(package! nroam :recipe (:host github :repo "NicolasPetton/nroam"))

(package! org-ref)

;;(package! gkroam :recipe (:host github :repo "Kinneyzhang/gkroam"))

(package! org-brain :recipe (:build (:not compile)))

(package! ob-mermaid)

(package! org-spacer.el :recipe (:host github :repo "dustinlacewell/org-spacer.el"))

(package! org-treeusage :recipe (:host github :repo "mtekman/org-treeusage.el"))

(package! org-super-links :recipe (:host github
                       :repo "toshism/org-super-links"
                       :files ("*.el")
                       ))

(package! wikinfo :recipe (:host github
                             :repo "progfolio/wikinfo"
                             ))

(package! wikinforg :recipe (:host github
                             :repo "progfolio/wikinforg"
                             ))

(package! org-noter-plus :recipe (:host github :repo "yuchen-lea/org-noter-plus"))

(package! ox-ipynb :recipe (:host github :repo "jkitchin/ox-ipynb"))

(package! org-html-themify :recipe (:host github :repo "DogLooksGood/org-html-themify"
                                    :files ("*.el" "*.js" "*.css")))

(package! org-link-beautify :recipe (:host github
                             :repo "stardiviner/org-link-beautify"
                             ))

(package! org-working-set
)

(package! org-tanglesync)

;; (package! org-graph-view :recipe (:host github :repo "alphapapa/org-graph-view"))

(package! org-mind-map :recipe (:host github :repo "the-humanities/org-mind-map"))
