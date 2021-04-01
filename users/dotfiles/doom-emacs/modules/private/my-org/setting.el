;;; setting.el -*- lexical-binding: t; -*-
(setq org-publish-project-alist
      '(
        ("init"
         :base-directory "~/.config/nixpkgs/dotfiles/doom-emacs"
         :publishing-function org-html-publish-to-html
         :publishing-directory "~/Documents/my-blog/public/custom"
         )
        ))

;; (defun endless/export-audio-link (path desc format)
;;   "Export org audio links to hmtl."
;;   (cl-case format
;;     (html (format
;;        "<audio preload=\"auto\"> <source src=\"https://www.gtrun.org/music/%s\">%s</audio>"
;;        path (or desc "")))

;;     ;; README: hugo music file path
;;     (md (format
;;      "<audio class=\"wp-audio-shortcode\"  loop=\"1\"  preload=\"auto\" style=\"width: 100%%;\" controls> <source src=\"https://www.gtrun.org/music/%s\">%s</audio>"
;;      path (or desc "")))
;;     (latex (format "(HOW DO I EXPORT AUDIO TO LATEX? \"%s\")" path))))

;; (after! org
;;   (org-add-link-type "audio" #'ignore #'endless/export-audio-link)
;;   ;;(setq org-download-timestamp "%Y%m%d_%H%M%S")
;; )
