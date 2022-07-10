;; Setup package
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("GNU ELPA" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; List of packages to install
(setq package-list '(lsp-mode badwolf-theme flycheck clang-format evil smartparens counsel company))

;; Initialize package
(package-initialize)

;; Update packages
(unless package-archive-contents
  (package-refresh-contents)
  (package-install 'use-package))

;; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
