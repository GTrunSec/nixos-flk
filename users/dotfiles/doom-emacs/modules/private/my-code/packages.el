;;; modules/private/my-code/packages/packages.el -*- lexical-binding: t; -*-

(package! org-latex-impatient :recipe (:host github :repo "yangsheng6810/org-latex-impatient"))

(package! lsp-haskell)

(package! lsp-julia :recipe (:host github :repo "non-Jedi/lsp-julia"))

(package! julia-snail :recipe (:host github
                                   :repo "gcv/julia-snail"
                                   :files ("*")
                                   ))

(package! lsp-pyright)

;;(package! nox :recipe (:host github :repo "manateelazycat/nox"))

(package! zeek-mode :recipe (:host github :repo "ynadji/zeek-mode"))

(package! separedit :recipe (:host github :repo "twlz0ne/separedit.el"))
