;; Setup package
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))

;; List of packages to install
(setq package-list '(evil smartparens counsel))

;; Initialize package
(package-initialize)

;; Bootstrap package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))

;; Install the missing packages
(dolist (package package-list)
	(unless (package-installed-p package)
		(package-install package)))
