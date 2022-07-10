;; Load in packages
(load "~/.emacs.d/packages")

;; Set theme and font
(require 'modus-themes)
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-paren-match '(bold intense)
      modus-themes-region '(accented bg-only)
      modus-themes-prompts '(bold intense)
      modus-themes-completions '((matches . (extrabold))
                                 (selection . (semibold accented))
                                 (popup . (accented intense))))
(modus-themes-load-themes)
(modus-themes-load-vivendi)
(set-face-attribute 'default (selected-frame) :height 110)

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Make C-z behave like other apps
(define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
(define-key evil-emacs-state-map (kbd "C-z") 'suspend-frame)
(define-key evil-motion-state-map (kbd "C-x C-z") 'evil-emacs-state)
(define-key evil-emacs-state-map (kbd "C-x C-z") 'evil-exit-emacs-state)
(define-key evil-motion-state-map (kbd "C-f") nil)

;; Enable ivy
;;(require 'counsel)
;;(ivy-mode 1)
;;(setq ivy-count-format "(%d/%d) ")

;; Set ivy bindings
(global-set-key (kbd "C-f") 'counsel-find-file)
(global-set-key (kbd "C-s") 'swiper-isearch)

;; Enable company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Enable smartparens
(require 'smartparens)
(add-hook 'prog-mode-hook 'smartparens-mode)
(setq sp-highlight-pair-overlay nil)

;; Enable clang-format on save
(add-hook 'c++-mode-hook
  (lambda ()
    (add-hook (make-local-variable 'before-save-hook)
              'clang-format-buffer)))

;; Enable flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
(setq flycheck-indication-mode nil)

;; Show matching parenthesis
(show-paren-mode 1)

;; Prevent emacs to adding custom settings
(setq custom-file (make-temp-file "emacs-custom"))

;; Don't display the startup screen
(setq inhibit-startup-screen t)

;; Remove trailing whitespace on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; Enable line number
(display-line-numbers-mode)

;; 4-space tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(c-set-offset 'comment-intro 0)

;; Keep buffers automatically up to date
(global-auto-revert-mode t)

;; Remove window decoration
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Follow symlinks
(setq vc-follow-symlinks nil)

;; Save all backup files to the same location
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

;; Better performance
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)
