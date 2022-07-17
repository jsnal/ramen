;; Load in packages
(load "~/.emacs.d/packages")

;; Set theme and font
(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/")
(load-theme 'darcula t)
(set-face-attribute 'default (selected-frame) :height 100)

;; Enable Evil
(require 'evil)
(evil-mode 1)

(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)

;; Make C-z behave like other apps
(define-key evil-motion-state-map (kbd "C-z") 'suspend-frame)
(define-key evil-emacs-state-map (kbd "C-z") 'suspend-frame)
(define-key evil-motion-state-map (kbd "C-x C-z") 'evil-emacs-state)
(define-key evil-emacs-state-map (kbd "C-x C-z") 'evil-exit-emacs-state)
(define-key evil-motion-state-map (kbd "C-f") nil)
(define-key evil-motion-state-map (kbd "C-b") nil)

;; Enable company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Enable smartparens
(require 'elec-pair)
(add-hook 'after-init-hook 'electric-pair-mode)

;; Enable clang-format on save
(require 'clang-format)
(add-hook 'c++-mode-hook
  (lambda ()
    (add-hook (make-local-variable 'before-save-hook)
              'clang-format-buffer)))

;; Enable flycheck
(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))

;; Set key bindings
(global-set-key (kbd "C-f") 'find-file)
(global-set-key (kbd "C-b") 'switch-to-buffer)

;; Setup interactive completion
(require 'ido)
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-confirm-unique-completion nil)
(setq ido-create-new-buffer nil)
(setq ido-create-new-buffer nil)
(setq ido-decorations (quote ("" "" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; Use IDO for M-x
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

;; Show matching parenthesis
(show-paren-mode 1)

;; Prevent emacs to adding custom settings
(setq custom-file (make-temp-file "emacs-custom"))

;; Don't display the startup screen
(setq inhibit-startup-screen t)

;; Remove trailing whitespace on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; Enable line number
(global-display-line-numbers-mode)

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
