(when (version< emacs-version "29")
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'package-archives
	         '("MELPA" .
	           "http://melpa.org/packages/"))

(use-package use-package
  :custom
  (use-package-always-defer nil)
  (use-package-verbose t)
  (use-package-minimum-reported-time 0)
  (use-package-expand-minimally nil)
  (use-package-enable-imenu-support t))

(use-package base16-theme
  :ensure t
  :init
  (load-theme 'base16-bright t)
  :config
  (set-face-attribute 'default (selected-frame) :height 110)
  (set-face-foreground 'line-number-current-line "#ffff00")
  (set-cursor-color "#ffffff"))

(use-package evil
  :ensure t
  :init
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map "\C-h" 'evil-window-left)
  (define-key evil-normal-state-map "\C-j" 'evil-window-down)
  (define-key evil-normal-state-map "\C-k" 'evil-window-up)
  (define-key evil-normal-state-map "\C-l" 'evil-window-right))

(use-package elec-pair
  :ensure t
  :init
  (electric-pair-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (c-mode . lsp-deferred)
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-signature-render-documentation nil))

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(setq custom-file (make-temp-file "emacs-custom"))
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(add-hook 'write-file-hooks 'delete-trailing-whitespace)

(global-display-line-numbers-mode)
(global-auto-revert-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq confirm-kill-emacs 'y-or-n-p)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(c-set-offset 'comment-intro 0)
