;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(setq inhibit-startup-screen t)

;; Fonts
(set-frame-font "Inconsolata 11" nil t)

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
;;    :url "https://framagit.org/steckerhalter/quelpa-use-package.git")lflflflflf)
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
  (setq ivy-use-virtual-buffers t ;; use virtual buffers
	ivy-count-format "%d/%d "
	ivy-re-builders-alist '((t . ivy--regex-fuzzy)) ;; Use fuzzy finding in searches
	ivy-initial-inputs-alist nil)) ;; Remove initial '^' in ivy searches

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

(use-package magit
  :ensure t)
(use-package evil-magit
  :ensure t)

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
			  ))
  org-hide-leading-stars t)

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

(use-package multishell
  :ensure t)

;; Load all .el files under .emacs.d/config
(load "~/.emacs.d/load-directory.el")
(load-directory "~/.emacs.d/config")

(use-package evil-mc
  :ensure t
  :config
  (global-evil-mc-mode 1)
  (push 'evil-escape-mode evil-mc-incompatible-minor-modes))
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
	   "fR"  '((lambda () (interactive) (revert-buffer :ignore-auto :noconfirm)) :which-key "reload current buffer from disk")
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
	   "wl"  '(evil-window-right :which-key "move right")
	   "wh"  '(evil-window-left :which-key "move left")
	   "wk"  '(evil-window-up :which-key "move up")
	   "wj"  '(evil-window-down :which-key "move down")
	   "wL"  '(evil-window-move-far-right :which-key "move right")
	   "wH"  '(evil-window-move-far-left :which-key "move left")
	   "wK"  '(evil-window-move-very-top :which-key "move up")
	   "wJ"  '(evil-window-move-very-bottom :which-key "move down")
	   "wv"  '(split-window-right :which-key "split right")
	   "ws"  '(split-window-below :which-key "split below")
	   "wd"  '(delete-window :which-key "delete window")
	   "wfn" '(make-frame :which-key "open new Emacs window")
	   ;;Apps
	   "att" '(multi-term :which-key "open terminal")
	   "atn" '(multi-term-next :which-key "switch to next term buffer")
	   "atp" '(multi-term-prev :which-key "switch to previous term buffer")
	   "ajj" '(org-journal-new-entry :which-key "new journal entry"lflf)
	   "ajv" '(org-journal-display-entry :which-key "view today's journal")
	   "ajp" '(org-journal-previous-entry :which-key "view next journal entry")
	   "ajn" '(org-journal-next-entry :which-key "view previous journal entry")
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
	   ;; Magit
	   "gs"  'magit-status
	   "gc"  'magit-commit
	   "gd"  'magit-diff
	   "gt"  'magit-tag
	   ;; Colorscheme
	   "Ts"  'toggle-dark-light-theme
	   ))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
