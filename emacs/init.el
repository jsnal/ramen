(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package use-package
  :custom
  (use-package-always-defer nil)
  (use-package-always-ensure t)
  (use-package-verbose t)
  (use-package-minimum-reported-time 0)
  (use-package-expand-minimally nil)
  (use-package-enable-imenu-support t))

(use-package base16-theme
  :init
  (load-theme 'base16-bright t)
  :config
  (set-face-attribute 'default (selected-frame) :height 110)
  (set-face-foreground 'line-number-current-line "#ffff00")
  (set-cursor-color "#ffffff"))

(use-package evil
  :init
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map "\C-h" 'evil-window-left)
  (define-key evil-normal-state-map "\C-j" 'evil-window-down)
  (define-key evil-normal-state-map "\C-k" 'evil-window-up)
  (define-key evil-normal-state-map "\C-l" 'evil-window-right))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package elec-pair
  :init
  (electric-pair-mode))

(use-package eglot
  :defer t
  :bind (:map eglot-mode-map
              ("C-c C-f" . eglot-format-buffer))
  :hook ((python-mode . eglot-ensure)
         (c-mode . eglot-ensure)))

(use-package corfu
  :after
  eglot
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-auto-prefix 2)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs :after tree-sitter)

(global-set-key (kbd "C-x C-b") 'buffer-menu)

(setq custom-file (make-temp-file "emacs-custom"))
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(global-display-line-numbers-mode)
(global-auto-revert-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; indentation rules
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(c-set-offset 'comment-intro 0)

;; scroll by 1 line
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

;; various hooks
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(add-hook 'tree-sitter-after-on-hook 'tree-sitter-hl-mode)
