;; serape-theme.el -- Serape colorscheme

;;; Commentary:
;; Serape: Bright and vivid colorscheme

;;; Authors:
;; Jason Long <jalong4>

;;; Code:

;; (defvar serape-theme-colors
;;   '(:base00 "#000000"
;;     :base01 "#303030"
;;     :base02 "#505050"
;;     :base03 "#b0b0b0"
;;     :base04 "#d0d0d0"
;;     :base05 "#e0e0e0"
;;     :base06 "#f5f5f5"
;;     :base07 "#ffffff"
;;     :base08 "#fb0120"
;;     :base09 "#fc6d24"
;;     :base0A "#fda331"
;;     :base0B "#a1c659"
;;     :base0C "#76c7b7"
;;     :base0D "#6fb3d2"
;;     :base0E "#d381c3"
;;     :base0F "#be643c")
;;   "All colors for Serape are defined here.")

(deftheme serape)
(let ((class '((class color) (min-colors 89)))
      (color00 "#000000")
      (color01 "#303030")
      (color02 "#505050")
      (color03 "#b0b0b0")
      (color04 "#d0d0d0")
      (color05 "#e0e0e0")
      (color06 "#f5f5f5")
      (color07 "#ffffff")
      (color08 "#fb0120")
      (color09 "#fc6d24")
      (color0A "#fda331")
      (color0B "#a1c659")
      (color0C "#76c7b7")
      (color0D "#6fb3d2")
      (color0E "#d381c3")
      (color0F "#be643c"))
      (custom-theme-set-faces
       `serape

       ;;; Basic colors
       `(default                             ((,class (:foreground ,color05 :background ,color00))))
       `(border                              ((,class (:background ,color03))))
       `(cursor                              ((,class (:foreground ,color00))))
       `(fringe                              ((,class (:background ,color02))))
       `(gui-element                         ((,class (:background ,color01))))
       `(header-line                         ((,class (:foreground ,color0E :background nil :inherit mode-line))))
       `(highlight                           ((,class (:background ,color01))))
       `(link                                ((,class (:foreground ,color0D :underline t))))
       `(link-visited                        ((,class (:foreground ,color0E :underline t))))
       `(minibuffer-prompt                   ((,class (:foreground ,color0D))))
       `(region                              ((,class (:background ,color02 :distant-foreground ,color05))))
       `(secondary-selection                 ((,class (:background ,color03 :distant-foreground ,color05))))
       `(trailing-whitespace                 ((,class (:foreground ,color0A :background ,color0C))))
       `(vertical-border                     ((,class (:foreground ,color02))))
       `(widget-button                       ((,class (:underline t))))
       `(widget-field                        ((,class (:background color03 :box (:line-width 1 :color ,color06)))))

       `(error                               ((,class (:foreground ,color08 :weight bold))))
       `(warning                             ((,class (:foreground ,color09 :weight bold))))
       `(success                             ((,class (:foreground ,color0B :weight bold))))
       `(shadow                              ((,class (:foreground ,color03))))

       ;;; Compilation
       `(compilation-column-number           ((,class (:foreground ,color0A))))
       `(compilation-line-number             ((,class (:foreground ,color0A))))
       `(compilation-message-face            ((,class (:foreground ,color0D))))
       `(compilation-mode-line-exit          ((,class (:foreground ,color0B))))
       `(compilation-mode-line-fail          ((,class (:foreground ,color08))))
       `(compilation-mode-line-run           ((,class (:foreground ,color0D))))

       ;;; Custom
       `(custom-varaible-tag                 ((,class (:foreground color0D))))
       `(custom-group-tag                    ((,class (:foreground color0D))))
       `(custom-state                        ((,class (:foreground color0B))))

       ;;; Font lock
       `(font-lock-builtin-face              ((,class (:foreground base0C))))
       `(font-lock-comment-delimiter-face    ((,class (:foreground base03))))
       `(font-lock-comment-face              ((,class (:foreground base03))))
       `(font-lock-constant-face             ((,class (:foreground base09))))
       `(font-lock-doc-face                  ((,class (:foreground base04))))
       `(font-lock-doc-string-face           ((,class (:foreground base03))))
       `(font-lock-function-name-face        ((,class (:foreground base0D))))
       `(font-lock-keyword-face              ((,class (:foreground base0E))))
       `(font-lock-negation-char-face        ((,class (:foreground base0B))))
       `(font-lock-preprocessor-face         ((,class (:foreground base0D))))
       `(font-lock-regexp-grouping-backslash ((,class (:foreground base0A))))
       `(font-lock-regexp-grouping-construct ((,class (:foreground base0E))))
       `(font-lock-string-face               ((,class (:foreground base0B))))
       `(font-lock-type-face                 ((,class (:foreground base0A))))
       `(font-lock-variable-name-face        ((,class (:foreground base08))))
       `(font-lock-warning-face              ((,class (:foreground base08))))

       ;;; Line numbers
       `(line-number                         ((,class (:foreground ,color05 :background ,color01))))
       `(line-number-current-line            ((,class (:foreground ,color0A :background ,color01 :weight bold))))
       ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'serape)
(provide 'serape-theme)

;;; serape-theme.el ends here
