(load! "setting")
(use-package! ox-hugo)
(use-package! ob-session-async)

(after! org
  (when IS-LINUX
    (setq org-id-locations-file (concat org-directory "/cache/.linux-orgids"))
    )

  (when IS-MAC
    (setq org-id-locations-file (concat org-directory "/cache/.mac-orgids"))
    )

  (setq org-clock-into-drawer t)
  (add-hook! 'org-mode-hook 'auto-revert-mode)
  (add-hook! 'dired-mode-hook 'org-download-enable)
  ;; (setq-hook! 'org-mode-hook fill-column 80)
  ;; (setq-hook! 'org-mode-hook org-superstar-mode 1)
  (setq org-directory "~/Documents/org-notes")
  (setq org-log-into-drawer t)
  (setq org-agenda-start-day "-1d")
  (setq org-agenda-span 2)
  (setq org-time-clocksum-format '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))
  (setq org-archive-location (concat "%s_archive_" (format-time-string "%Y" (current-time)) "::"))
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state "⚔ INPROCESS")
  (setq org-src-fontify-natively t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-src-window-setup 'current-window)
  (setq org-agenda-time-leading-zero t)

  ;;Markdown
  (eval-after-load "org"
    '(require 'ox-md nil t))
  ;;https://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html

  (defun org-show-two-levels ()
    (interactive)
    (org-content 2))

  (setq org-download-timestamp "%Y%m%d_%H%M%S")

  (add-hook! 'org-mode-hook 'org-show-two-levels)
  (add-hook! 'after-init-hook 'org-id-update-id-locations)

  (add-hook! 'unpackaged/org-return-dwim 'unpackaged/org-fix-blank-lines)
  (define-key org-mode-map (kbd "C-c ;") 'org-time-stamp-inactive)
  (define-key org-mode-map (kbd "RET") 'unpackaged/org-return-dwim)
  (setq org-plantuml-jar-path (expand-file-name "~/.myscript/plantuml"))
  )

(use-package! org-starter
  :custom
  ;; Enable external configuration files loaded from org-starter-path
  (org-starter-load-config-files t)
  :config
  (org-starter-def "~/Documents/org-notes"
    :files
    ("posts/myself/love.org"         :key "l" :refile (:maxlevel . 5 ))
    ("posts/myself/qing.org"         :key "q" :refile (:maxlevel . 5 ))
    ("posts/myself/plan.org"         :key "p" :refile (:maxlevel . 5 ))
    )
  (org-starter-def "~/Documents/org-notes/braindump"
    :files
    ("myself-private/" :agenda t)
    ("myself-private/GTD/gtd.org"                      :key "g" :refile (:maxlevel . 5))
    ("myself-private/GTD/notes.org"                    :key "n" :refile (:maxlevel . 5 ))
    ("myself-private/GTD/myself.org"                    :key "m" :refile (:maxlevel . 5 ))
    ("myself-private/GTD/Habit.org"                     :key "h" :refile (:maxlevel . 5 ))
    ;;
    ("guangtao/" :agenda t)
    ("guangtao/learn_music.org"          :agenda t :key "M" :refile (:maxlevel . 5 ))
    ("guangtao/guangtao's_library.org"       :key "b" :refile (:maxlevel . 5 ))
    ("guangtao/guangtao's_feed.org"         :agenda t :key "f" :refile (:maxlevel . 5 ))
    ;;
    ("life/" :agenda t)
    ("life/life_goods.org"     :key "s" :refile (:maxlevel . 5 ))
    ("gaming/" :agenda t)
    ("journals/" :agenda t)
    ("hardware/" :agenda t)
    ("system/" :agenda t)
    ("deployment/" :agenda t)
    ("cs/" :agenda t)
    ("programming/" :agenda t)
    ("nix/" :agenda t)
    ("emacs/" :agenda t)
    ("security/" :agenda t)
    ("financial/" :agenda t)
    ("network/" :agenda t)
    ("data-science/" :agenda t)        
    )
  (org-starter-def "~/.config/nixpkgs/dotfiles/doom-emacs/"
    :files
    ("config.org" :key "c" :refile (:maxlevel . 5))
    ("meow.org" :key "w" :refile (:maxlevel . 5))
    )
  (org-starter-def "~/.config/nixpkgs"
    :files
    ("README.org")
    ("global-readme.org")
    ("dotfiles/wallpaper/wallpaper.org" :agenda nil)
    )

  (defhydra gtrun/hydra-org-starter nil
    "
  Org-starter-files
  ^^^^------------------------------------------------
 _c_: config.org  _g_: gtd.org     _l_: love.org
 _n_: note        _h_: Habit.org    _w_: meow.org
 _m_: myself      _p_: Plan.org
 _b_: my-books    _f_: feed
 _s_: life-goods
  "

    ("c" org-starter-find-file:config)
    ("w" org-starter-find-file:meow)
    ("g" org-starter-find-file:gtd)
    ("s" org-starter-find-file:life_goods)
    ("n" org-starter-find-file:notes)
    ("f" org-starter-find-file:feed)
    ("m" org-starter-find-file:myself)
    ("l" org-starter-find-file:love)
    ("h" org-starter-find-file:Habit)
    ("p" org-starter-find-file:plan)
    ("b" org-starter-find-file:guangtao\'\s_library)
    )
  :commands org-starter-load-all-files-in-path
  :hook
  (after-init . org-starter-load-all-files-in-path)
  :bind
  (
   ("C-c e" . org-starter-select-file))
  ;; "C-c e" . org-starter-refile-by-key))
  )

(use-package! org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱" ))
)

(use-package! org-ql)

(use-package! helm-org-rifle)

(use-package! org-books
  :config
  (setq org-books-file "~/Documents/org-notes/braindump/guangtao/guangtao's_library.org")
  )

(use-package! org-z
  :init
  (define-key org-mode-map (kbd "C-c C-;") 'org-z-insert-link)
  (require 'org-z-helm)
  ;;(require 'org-z-selectrum)
  :config
  (org-z-mode 1)
  (setq org-z-directories  '("~/Documents/org-notes/braindump"
                             "~/Documents/org-notes/braindump/guangtao"
                             "~/Documents/org-notes/braindump/journals"
                             "~/Documents/org-notes/braindump/cs"
                             "~/Documents/org-notes/braindump/network"
                             "~/Documents/org-notes/braindump/security"
                             "~/Documents/org-notes/braindump/life"
                             "~/Documents/org-notes/braindump/math"
                             "~/Documents/org-notes/braindump/math/my-mathematic-julia"
                             "~/Documents/org-notes/braindump/data-science"
                             "~/Documents/org-notes/braindump/deployment"
                             "~/Documents/org-notes/braindump/hardware"
                             "~/Documents/org-notes/braindump/system"
                             "~/Documents/org-notes/braindump/emacs"
                             "~/Documents/org-notes/braindump/gaming"
                             "~/Documents/org-notes/braindump/financial"
                             "~/Documents/org-notes/braindump/myself-private"
                             "~/Documents/org-notes/braindump/myself-private/GTD"
                             "~/Documents/org-notes/braindump/nix"
                             "~/Documents/org-notes/braindump/programming"
                             "~/.config/nixpkgs/dotfiles/doom-emacs"
                             ))

   )

(use-package! org-super-agenda
  :config
  (add-hook! 'after-init-hook 'org-super-agenda-mode)
  (require 'org-habit)
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-include-deadlines t
   org-agenda-include-diary nil
   org-agenda-block-separator nil
   org-agenda-compact-blocks t
   org-agenda-start-with-log-mode t)
  )

(setq org-todo-keywords
 '((sequence
       "TODO(t)"  ; A task that needs doing & is ready to do
       "PROJ(p)"  ; An ongoing project that cannot be completed in one step
       "INPROCESS(s)"  ; A task that is in progress
       "⚑ WAITING(w)"  ; Something is holding up this task; or it is paused
       "|"
       "☟ NEXT(n)"
       "✰ IMPORTANT(i)"
       "DONE(d)"  ; Task successfully completed
       "✘ CANCELED(c@)") ; Task was cancelled, aborted or is no longer applicable
      (sequence
       "✍ NOTE(N)"
       "FIXME(f)"
       "☕ BREAK(b)"
       "❤ LOVE(l)"
       "REVIEW(r)"
       )) ; Task was completed
    org-todo-keyword-faces
    '(
      ("TODO" . (:foreground "#ff39a3" :weight bold))
      ("INPROCESS"  . "orangered")
      ("✘ CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
      ("⚑ WAITING" . "pink")
      ("☕ BREAK" . "gray")
      ("❤ LOVE" . (:foreground "VioletRed4"
                               ;; :background "#7A586A"
                               :weight bold))
      ("☟ NEXT" . (:foreground "DeepSkyBlue"
                               ;; :background "#7A586A"
                                  :weight bold))
      ("✰ IMPORTANT" . (:foreground "greenyellow"
                                  ;; :background "#7A586A"
                                  :weight bold))
      ("DONE" . "#008080")
      ("FIXME" . "IndianRed")
      ))

(require 'org-super-agenda)
(setq org-agenda-custom-commands
      '(("z" "GtruN Agenda"
         ((agenda "" ((org-agenda-span 2)
                      (org-agenda-start-day "-1d")
                      (org-super-agenda-groups
                       '((:name "Today List"
                                :time-grid t
                                :date today
                                :todo "⚔ INPROCESS"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :priority>= "B"
                                 :order 2)
                          (:name "Important"
                                 :todo "✰ Important"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 3)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 20)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag ("BOOK" "READ")
                                 :order 30)
                          (:name "Waiting"
                                 :todo "⚑ WAITING"
                                 :order 18)
                          (:name "trivial"
                                 :priority<= "C"
                                 :todo ("SOMEDAY")
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))

        ("b" . "BOOK")

        ("bb" "Search tags in todo, note, and archives"
         search "+{:book\\|books:}")

        ("bd" "BOOK TODO List"
         search "+{^\\*+\\s-+\\(⚔ INPROCESS\\|TODO\\|⚑ WAITING\\)\\s-} +{:book\\|books:}")

        ("d" "ALL DONE OF TASKS"
         search "+{^\\*+\\s-+\\(✔ DONE\\|✘ CANCELED\\)\\s-}")

        ("i" "ALL INPROCESS OF TASKS"
         search "+{^\\*+\\s-+\\(⚔ INPROCESS\\)\\s-}")

        ))

(use-package! org-edna
  :config
  (add-hook! 'after-init-hook 'org-edna-mode)
)

(use-package! org-wild-notifier
  :defer t
  :config
  (add-hook! 'after-init-hook 'org-wild-notifier-mode)
  (setq ;;org-wild-notifier-alert-time 15
        alert-default-style (if IS-MAC 'osx-notifier 'libnotify)))

(after! ob-async
  (setq ob-async-no-async-languages-alist '("ipython" "ein-python"
                                            "ein-rust"
                                            "ein-julia"
                                            "ein-haskell"
                                            ))
  )

;;[[https://stackoverflow.com/questions/22668112/how-to-evaluate-all-code-blocks-when-exporting-in-emacs-org-mode][How to evaluate all code blocks when exporting in emacs org-mode - Stack Overflow]]
(setq org-confirm-babel-evaluate nil)
(setq org-export-use-babel nil)

(setq org-babel-C++-compiler 'clang++)
(setq org-babel-C-compiler 'clang)

;; 當被加密的部份要存入硬碟時，自動加密回去
  ;; 設定要加密的 tag 標籤為 secret
  (setq org-crypt-tag-matcher "secret")

  ;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
  ;; (但是子項目還是會被加密喔)
  (setq org-tags-exclude-from-inheritance (quote ("secret")))

  ;; 用於加密的 GPG 金鑰
  ;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
  (setq org-crypt-key nil)

(use-package! notdeft
  :config
  (setq notdeft-extension "org")
  ;;(setq notdeft-secondary-extensions '("md" "org" "scrbl"))
  (setq notdeft-xapian-program "/home/gtrun/.nix-profile/bin/notdeft-xapian")
  (when IS-MAC
    (setq notdeft-xapian-program "/Users/gtrun/.nix-profile/bin/notdeft-xapian")
    )
  (setq notdeft-directories '("~/Documents/org-notes/post/myself"
                              "~/Documents/org-notes/dailies"
                              "~/Documents/org-notes/post/traveling"
                              "~/Documents/org-notes/post/agenda"
                              "~/Documents/org-notes/post/game"
                              "~/Dropbox/project/my-learning-list"
                              "~/Documents/org-notes/GTD"
                              "~/Documents/org-notes/art"
                              "~/Documents/org-notes/braindump"
                              ))

  :bind (:map notdeft-mode-map
         ("C-q" . notdeft-quit)
         ("C-r" . notdeft-refresh)
         )
  )

(use-package! org-roam
  :init
  (require 'org-roam-protocol)
  :config
  (setq org-roam-index-file "~/Documents/org-notes/braindump/pages/contents.org")
  ;;https://github.com/zaeph/.emacs.d/blob/0f4bf9a500ef6397b93c41cb51602bea9ab9a4c3/init.el#L3804
  ;; [[https://copingmechanism.com/2020/keeping-org-roam-daily-notes-in-a-separate-folder/][Keeping Org-roam Daily Notes in a separate folder – Coping Mechanism]]
  ;; (setq org-roam-dailies-capture-templates '(("d" "daily" plain (function org-roam-capture--get-point) ""
  ;;                                             :immediate-finish t
  ;;                                             :file-name "dailies/%<%Y-%m-%d>-${slug}"
  ;;                                             :head "#+TITLE: %<%Y-%m-%d>-${slug}\n#+created: %u\n#+last_modified: %U\n\n")))
  )

;; (use-package! org-roam-server
;;   :config
;;   (setq org-roam-server-port 8081
;;         org-roam-server-export-inline-images t
;;         org-roam-server-authenticate nil
;;         org-roam-server-network-poll t
;;         org-roam-server-network-arrows nil
;;         org-roam-server-network-label-truncate t
;;         org-roam-server-network-label-truncate-length 60
;;         org-roam-server-network-label-wrap-length 20))

;; (use-package! org-roam-bibtex
;;   :config
;;   (add-hook 'org-mode-hook 'org-roam-bibtex-mode)
;;   :bind (:map org-roam-bibtex-mode-map
;;               ("C-c n a" . orb-note-actions)
;;               )
;;   )

(use-package! nroam
  :after org-roam
  :config
  (add-hook 'org-mode-hook #'nroam-setup-maybe))

(use-package! org-ref
  :config
  (defsubst dnd-unescape-uri (uri)
  (replace-regexp-in-string
   "%[A-Fa-f0-9][A-Fa-f0-9]"
   (lambda (arg)
     (let ((str (make-string 1 0)))
       (aset str 0 (string-to-number (substring arg 1) 16))
       str))
   uri t t))
  (setq org-ref-default-bibliography '("~/Documents/org-notes/braindump/bibliography/myBibliography.bib"))
  (setq bibtex-completion-bibliography "~/Documents/org-notes/braindump/bibliography/myBibliography.bib")
  )

;; (defun org-roam-dailies-capture-today ()
;;   "Capture a note into the daily note for today."
;;   (interactive)
;;   (let ((org-roam-capture-templates org-roam-dailies-capture-templates)
;;         (org-roam-capture--info (list (cons 'time (current-time))))
;;         (org-roam-capture--context 'dailies))
;;     (org-roam--capture)))

;; (setq org-capture-templates '(("n" "Note" entry (function org-roam-dailies-capture-today)
;;                                  "* %?\n")))

(use-package! org-journal
  :config
  (setq org-journal-dir "~/Documents/org-notes/braindump/journals")
  (setq org-journal-file-format "%Y_%m_%d.org")
  )

;; (use-package gkroam
;;   :hook (after-init . gkroam-mode)
;;   :init
;;   (setq gkroam-root-dir "~/Documents/org-notes/braindump")
;;   (setq gkroam-prettify-page-p t
;;         gkroam-show-brackets-p nil
;;         gkroam-use-default-filename t
;;         gkroam-window-margin 4)
;;   )

(use-package! org-brain
  :config
  (setq org-brain-visualize-default-choices 'all
        org-brain-title-max-length 24
        org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil)
  (setq org-brain-path "~/Documents/org-notes/braindump")
  )

(use-package! ob-mermaid
  :config
  (setq ob-mermaid-cli-path "~/.nix-profile/bin/mmdc")
  )

;; (use-package! org-spacer
;;   :config
;;   ;; (add-hook 'org-mode-hook
;;   ;;           (lambda () (add-hook 'before-save-hook
;;   ;;                                'org-spacer-enforce nil 'make-it-local)))
;;   )

(use-package! org-treeusage
  :config
  (define-key org-mode-map (kbd "C-c d") 'org-treeusage-mode)
  )

(use-package! org-super-links
  :config
  (defun org-super-links-backlink-prefix-timestamp ()
  "Return the default prefix string for a backlink.
Inactive timestamp formatted according to `org-time-stamp-formats' and
a separator ' <- '."
  (let* ((time-format (substring (cdr org-time-stamp-formats) 1 -1))
	 (time-stamp (format-time-string time-format (current-time))))
    (format " - [%s] <- "
	    time-stamp)))

(defun org-super-links-link-prefix-timestamp ()
  "Return the default prefix string for a backlink.
Inactive timestamp formatted according to `org-time-stamp-formats' and
a separator ' -> '."
  (let* ((time-format (substring (cdr org-time-stamp-formats) 1 -1))
	 (time-stamp (format-time-string time-format (current-time))))
    (format " - [%s] -> "
	    time-stamp)))

(defun org-super-links-quick-insert-inline-link ()
  "Insert inline link regardless of variable `org-super-links-related-into-drawer' value."
  (interactive)
  ;; how to handle prefix here?
  (let ((org-super-links-related-into-drawer nil)
	(org-super-links-link-prefix 'org-super-links-link-prefix-timestamp))
    (org-super-links-link)))

(defun org-super-links-quick-insert-drawer-link ()
  "Insert link into drawer regardless of variable `org-super-links-related-into-drawer' value."
  (interactive)
  ;; how to handle prefix here?
  (let ((org-super-links-related-into-drawer (or org-super-links-related-into-drawer nil))
	(org-super-links-link-prefix 'org-super-links-backlink-prefix-timestamp))
    (org-super-links-link)))

(setq org-id-link-to-org-use-id
        'create-if-interactive-and-no-custom-id)

  (setq org-super-links-related-into-drawer nil
        org-super-links-backlink-into-drawer nil
        org-super-links-link-prefix 'org-super-links-link-prefix-timestamp)
  )

(use-package! wikinfo)
(use-package! wikinforg)

(use-package! org-noter-plus
  :config
  (setq org-noter-plus-image-dir "~/Documents/org-notes/braindump/.attach")
)

(use-package! ox-ipynb)

;; (use-package! org-html-themify
;;   :hook (org-mode . org-html-themify-mode)
;;   :custom
;;   (org-html-themify-themes
;;    '((dark . doom-one)
;;      (light . doom-one)))
;;   )

(use-package! org-link-beautify
  :config
  (add-hook! 'org-mode-hook 'org-link-beautify-mode)
  )

(use-package! org-working-set)

(use-package! org-tanglesync
  :config
  :hook (((prog-mode text-mode) . org-tanglesync-watch-mode))
  :custom
  (org-tanglesync-watch-files '("~/.config/nixpkgs/dotfiles/README-dotfiles.org"
                                "~/.config/nixpkgs/README-home-manager.org"
                                "~/.config/nixpkgs/nixos-flk/README-NixOS.org"
                                ))
  :config
  ;; (add-hook 'org-mode-hook (lambda ()
  ;;                            ;;……
  ;;                            (cond
  ;;                             ((equal (substring buffer-file-name -11) "-README.org")
  ;;                              (progn
  ;;                                (setq-local org-tanglesync-mode t)
  ;;                                ))
  ;;                              ))
  ;;                            )

  :bind
  (( "C-c M-i" . org-tanglesync-process-buffer-interactive)
   ( "C-c M-a" . org-tanglesync-process-buffer-automatic))
  )

;;(use-package! org-graph-view)

(use-package! org-mind-map
  :init
  (require 'ox-org)
  :config
  (setq org-mind-map-engine "circo")
  )
