;; Load in packages
(load "~/.emacs.d/packages")

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
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-display-style nil)

;; Set ivy bindings
(global-set-key (kbd "C-f") 'counsel-find-file)
(global-set-key (kbd "C-s") 'swiper-isearch)

;; Set theme
(load-theme 'misterioso t)

;; Auto closing parenthesis
(use-package smartparens
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode))

;; Prevent emacs to adding custom settings
(setq custom-file (make-temp-file "emacs-custom"))

;; Don't display the startup screen
(setq inhibit-startup-screen t)

;; Remove trailing whitespace on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; Enable line number
(global-linum-mode t)
(setq linum-format "%4d ")

;; Remove window decoration
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Save all backup files to the same location
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)
