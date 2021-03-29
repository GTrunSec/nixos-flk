(use-package org-latex-impatient
  ;;:hook (org-mode . org-latex-instant-preview-mode)
  :config
  (add-hook 'org-latex-impatient-mode-hook (lambda () (awesome-tab-mode -1)))

  (when IS-LINUX
    (setq org-latex-impatient-tex2svg-bin "/run/current-system/sw/bin/tex2svg")
    (setq org-latex-impatient-scale 10.0)
    )

  (when IS-MAC
    (setq org-latex-impatient-tex2svg-bin
          "~/.nix-profile/bin/tex2svg")
    (setq org-latex-impatient-scale 5.0)
    )
  )
