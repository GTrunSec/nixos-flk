;;; config..el -*- lexical-binding: t; -*-

(load! "my-latex")

(use-package! lsp-haskell
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp)
)

(use-package! ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp)))
  )

(use-package! polymode
:config
  (add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode)
)

(use-package! poly-markdown
  :config
  (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown-mode))
)

(use-package! lsp-julia
  :config
  ;;(add-hook 'julia-mode-hook #'lsp)
  ;;(setq lsp-julia-default-environment "~/.julia/environments/v1.5")
  (setq lsp-folding-range-limit 100)
)

(use-package! julia-snail
  :config
  :requires vterm
  :hook (julia-mode . julia-snail-mode)
  )

(setq flycheck-python-pylint-executable "pylint")
(use-package! lsp-pyright
  :config
  (setq lsp-clients-python-command "pyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; (use-package! nox
;;   :config
;;   (add-to-list 'nox-server-programs '(haskell-mode . ("ghcide" "--lsp")))
  ;; (dolist (hook (list
  ;;                'js-mode-hook
  ;;                'rust-mode-hook
  ;;                'python-mode-hook
  ;;                'ruby-mode-hook
  ;;                'java-mode-hook
  ;;                'sh-mode-hook
  ;;                'php-mode-hook
  ;;                'c-mode-common-hook
  ;;                'c-mode-hook
  ;;                'c++-mode-hook
  ;;                'haskell-mode-hook
  ;;                ))
  ;;   (add-hook hook '(lambda () (nox-ensure))))
  ;; )

(use-package! zeek-mode
  :config
  (setq default-tab-width 4)
  (defun add-company-tabnine ()
    (add-to-list (make-local-variable 'company-backends) 'company-tabnine))
  (add-hook 'zeek-mode-hook #'add-company-tabnine)
  )

(use-package! nix-mode
  :config
  (setq-hook! 'nix-mode-hook company-idle-delay t)
  )

(after! rust
  (seqpetq racer-cmd "racer")
  (add-hook 'rustic-mode-hook (lambda () (setq-local +lsp-company-backends '(company-capf
                                                                             company-tabnine))
                                ))
  )

;; 
(use-package! separedit
  :config
  (define-key prog-mode-map        (kbd "C-x '") #'separedit)
  (define-key minibuffer-local-map (kbd "C-x '") #'separedit)
  (define-key org-src-mode-map     (kbd "C-x '") #'separedit)
  )
