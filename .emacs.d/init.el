;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Fonts
(set-frame-font "Inconsolata 12" nil t)

;; Toggle on line numbers by default
(global-display-line-numbers-mode)

;; package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Use quelpa to enable use of some git repos
;; (use-package quelpa
;;   :ensure t)
;; (quelpa
;;  '(quelpa-use-package
;;    :fetcher git
;;    :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
;; (require 'quelpa-use-package)

;; Cross over to the VIM DARK SIDE
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode 1))
;; Adds `fd` as an evil escape key
(use-package evil-escape
  :ensure t
  :config
  (evil-escape-mode))
(use-package evil-collection
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

;; Theming framework
(use-package base16-theme
  :ensure t)

;; Shows available keypresses ala spacemacs
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package ivy
  :ensure t
  :demand
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d "
	ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

(use-package swiper
  :ensure t)

(use-package counsel
  :ensure t)
(use-package counsel-dash
  :ensure t
  :config
  (setq counsel-dash-common-docsets '("Javascript" "HTML" "Python" "Sass")))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package org-journal
  :ensure t
  :init
  (setq org-journal-file-format "%Y%m%d.org"
  org-journal-dir "~/Docs/Org/Journal"))

(use-package org
  :ensure t
  :init
  (setq 
  org-directory "~/Docs/Org"
  org-agenda-files (list org-journal-dir org-directory)
  org-capture-templates '(
			  ("t" "Todo" entry (file+headline "~/Docs/Org/gtd.org" "Tasks")
			   "* TODO %?\n  %i\n  %a")
			  ("n" "Note" entry (file+olp "~/Docs/Org/notes.org")
			   "* %?\nCreated on %U\n  %i\n  %a")
			  )))

;; Enable LSP support
(use-package lsp-mode
  :ensure t
  :config
  (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))
;; And UI for things like autocompletions
(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  
;; JAVASCRIPT

(use-package js2-mode
  :ensure t
  :config
  ;; Set js2-mode as the JavaScript major-omde
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;; Add LSP support for JavaScript
(use-package lsp-javascript-typescript
  :ensure t
  :config
  (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
  (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
  (add-hook 'js2-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
  (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable)) ;; for rjsx-mode support

;; Load all .el files under .emacs.d/config
(load "~/.emacs.d/load-directory.el")
(load-directory "~/.emacs.d/config")

;; Custom keybindings

(use-package general
  :ensure t
  :config (general-define-key
	   :states '(normal visual insert emacs)
	   :prefix "SPC"
	   :non-normal-prefix "M-SPC"
	   ;; Main arsenal
	   "SPC" '(counsel-M-x :which-key "M-x")
	   "/"   '(counsel-rg :which-key "ripgrep")
	   ;; Files
	   "ff"  '(counsel-find-file :which-key "find files")
	   "fr"  '(counsel-recentf :which-key "find recent files")
	   ;; Config
	   "fei" '((lambda ()
		    (interactive)
		    (split-window-right)
		    (find-file user-init-file))
		    :which-key "edit init.el")
	   "fer" '((lambda ()
		    (interactive)
		    (load-file user-init-file))
		    :which-key "reload init.el")
	   ;; Window creation and movement
	   "wl"  '(windmove-right :which-key "move right")
	   "wh"  '(windmove-left :which-key "move left")
	   "wk"  '(windmove-up :which-key "move up")
	   "wj"  '(windmove-down :which-key "move down")
	   "wv"  '(split-window-right :which-key "split right")
	   "ws"  '(split-window-below :which-key "split below")
	   "wd"  '(delete-window :which-key "delete window")
	   ;;Apps
	   "att" '(ansi-term :which-key "open terminal")
	   "ajj" '(org-journal-new-entry :which-key "new journal entry")
	   "ajv" '(org-journal-display-entry :which-key "view today's journal")
	   ;; Help
	   "hdv" 'counsel-describe-variable
	   "hdf" 'counsel-describe-function
	   "hdk" 'describe-key
	   ;; Comments
	   "Cl"  'comment-line
	   ;; Complation/Completion
	   "cc"  '(completion-at-point :which-key "complete item at point")
	   ;; Definitions
	   "dg"  '(xref-find-definitions :which-key "goto definition at point")
	   "dr"  '(xref-find-references :which-key "find references for symbol at point")
	   ;; Toggles
	   "tn"  '(display-line-numbers-mode :which-key "toggle line numbers")
	   ;; Search (and replace)
	   "ss"  '(swiper-all :which-key "edit matches one-by-one")
	   "sS"  '(swiper-multi :which-key "edit matches across files one-by-one")
	   ;; Project
	   "pp"  '(projectile-switch-project :which-key "open known project")
	   "pa"  '(projectile-add-known-project :which-key "add project to list")
	   "pA"  '(projectile-discover-projects-in-directory :which-key "discover projects in directory")
	   "ps"  '(projectile-ripgrep :which-key "search in project")
	   "pf"  '(projectile-find-file :which-key "find files in project")
	   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (counsel-dash projectile lsp-javascript-typescript emacs-lsp evil-collection org-journal counsel-rg counsel swiper evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

