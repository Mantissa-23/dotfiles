;; ------------------------------- General setup ---------------------------- ;;

(setq frame-resize-pixelwise t)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(setq-default inhibit-startup-screen t)

;; Fonts
(set-frame-font "Inconsolata 12" nil t)

;; Toggle on line numbers by default
(global-display-line-numbers-mode)

;; Color lines exceeding 80 columns in prog-modes
(setq-default
 whitespace-line-column 80
 whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook #'whitespace-mode)

;; Enable save-desktop so layouts are restored on boot
;(desktop-save-mode 1)

;; Save auto backup files to .emacs.d directory so they don't
;; clutter up motherfucking everything
(setq-default backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; Turn on visual line mode for text-mode buffers
(add-hook 'text-mode '(visual-line-mode 1))
;; At the expense of memory usage, don't slow to a fucking
;; crawl when encountering unicode characters.
(setq-default inhibit-compacting-font-caches t)

;; ------------------------------ Initialization ---------------------------- ;;

;; use package.el and add repos
(require 'package)
(setq-default package-enable-at-startup nil)
(setq-default package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq-default use-package-always-ensure t)

;; Use quelpa to enable use of some git repos
;; (use-package quelpa)
;; (quelpa
;;  '(quelpa-use-package
;;    :fetcher git
;;    :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
;; (require 'quelpa-use-package)

;; -------------------------------- Packages -------------------------------- ;;
;; And per-package configuration

;;                  -------------- Aesthetics --------------                  ;;

;; Theming framework
(use-package base16-theme)

;; Use variable-pitch font for non-code and fixed-pitch for code
;; (mainly for org-mode)
(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode)) ; use mixed-pitch everywhere with text

;;                  ----------------- Evil -----------------                  ;;

;; Cross over to the VIM DARK SIDE
(use-package evil
  :init
  (setq-default evil-want-integration nil)
  :config
  (evil-mode 1))

;; Adds `fd` as an evil escape key
(use-package evil-escape
  :config
  (evil-escape-mode))

;; A bunch of evil configs that make Emacs more evil.
(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

;; Multiple cursors for Evil
(use-package evil-mc
  :after evil
  :config
  (global-evil-mc-mode 1)
  (push 'evil-escape-mode evil-mc-incompatible-minor-modes))
;; Custom keybindings

;;                ---------- Completion Framework ----------                  ;;

(use-package ivy
  :demand
  :config
  (setq-default ivy-use-virtual-buffers t ;; use virtual buffers
	ivy-count-format "%d/%d " ;; No fuckin' clue
	ivy-re-builders-alist '((t . ivy--regex-fuzzy)) ;; Use fuzzy finding
	ivy-initial-inputs-alist nil)) ;; Remove initial '^' in ivy searches

;; Minibuffer completion with Ivy
(use-package counsel)

;; Browse docsets with Counsel. Still dunno how to use this one.
(use-package counsel-dash
  :config
  (setq-default
   counsel-dash-docsets-path "~/.docset"
   counsel-dash-docsets-url "https://raw.github.com/Kapeli/feeds/master"
   counsel-dash-common-docsets '("Javascript" "HTML" "Python" "Sass" "C++"))
   (add-hook 'emacs-lisp-mode-hook
             (lambda () (setq-local counsel-dash-docsets '("Emacs Lisp"))))
   (add-hook 'c++-mode-hook
             (lambda () (setq-local counsel-dash-docsets '("C++")))))


;; Rapid cross-file search jumping with Counsel/Ivy
(use-package swiper)

;;                --------------- Org-Mode -----------------                  ;;

;; Emacs's framework for organizing your life in plaintext
(use-package org
  :init
  (load-library "find-lisp")
  (setq-default
   org-directory "~/Docs/Org/"
   org-agenda-files (find-lisp-find-files org-directory "\.org$")
   org-capture-templates '(
			   ("t" "Todo" entry
			    (file+headline "~/Docs/Org/gtd.org" "Tasks")
			    "* TODO %?\n  %i\n  %a")
			   ("n" "Note" entry
			    (file+olp "~/Docs/Org/notes.org")
			    "* %?\nCreated on %U\n  %i\n  %a")
			   )
   org-hide-leading-stars t)
  ;; Enable flychecking of org src blocks
  (defadvice org-edit-src-code (around set-buffer-file-name activate compile)
    (let ((file-name (buffer-file-name))) ;; (1)
      ad-do-it                            ;; (2)
      (setq-default buffer-file-name file-name)))) ;; (3)

;; Journals in org-mode
(use-package org-journal
  :after org
  :init
  (setq-default org-journal-file-format "%Y%m%d.org"
  org-journal-dir "~/Docs/org/Journal")) ; Custom journal name format

;; Evil keybindings in org
(use-package evil-org
  :after (evil org)
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;;                ----------- Project Management -----------                  ;;

;; Lightweight project-management framework
(use-package projectile
  :config
  (projectile-mode +1))

;; Git integration
(use-package magit)

;; Evil keybinds for git integration
(use-package evil-magit
  :after (evil magit))

;;                ---------- General Development -----------                  ;;

;; Company completion framework
(use-package company
  :config
  (add-hook 'prog-mode-hook 'company-mode)) ;; Use in any prog-mode

;; DOCUMENTATION ON HOVER? IN MY EMACS?
(use-package pos-tip)

(use-package company-quickhelp
  :config
  (add-hook 'prog-mode-hook 'company-quickhelp-mode))

;; Flycheck syntax checker
(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode)) ;; Use in any prog-mode

;; Flyspell spelling checker
(use-package flyspell
  :config
  (add-hook 'text-mode-hook 'flyspell-mode))

;; Enable Language Server Protocol support
(use-package lsp-mode
  :config
  (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

(use-package yasnippet
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets)

;; And UI for things like autocompletions
(use-package lsp-ui
  :after lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Company integration for LSP
(use-package company-lsp
  :after (company lsp-mode)
  :config
  (push 'company-lsp company-backends))

;; Smartparens
(use-package smartparens
             :config
             (add-hook 'prog-mode-hook #'smartparens-mode))
  
;;                ------------ Web Development -------------                  ;;

;; js2 mode > jsmode
(use-package js2-mode
  :config
  ;; Set js2-mode as the JavaScript major-omde
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;; Add LSP support for JavaScript with the npm Typescript server
;; Remember to npm -g i javascript-typescript-langserver
(use-package lsp-javascript-typescript
  :config
  (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
  ;; for typescript support
  (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable)
  ;; for js3-mode support
  (add-hook 'js2-mode-hook #'lsp-javascript-typescript-enable)
  ;; for rjsx-mode support
  (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable))

;; Fantastic syntax highlighting for HTML and other templates.
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  )

;;                ----------- CS2102: Theorems -------------                  ;;

;; Enable lean theorem prover integration
(use-package lean-mode)

;; Enable company integration with lean theorem prover
(use-package company-lean
  :after company)

;;                -------------- Miscellaneous -------------                  ;;

;; Grep on steroids, integrates with Projectile and Counsel
(use-package ripgrep)

;; Easy management of multiple shell buffers.
(use-package multishell)

;; Shows available keypresses ala spacemacs
(use-package which-key
  :init
  (setq-default which-key-separator " ")
  (setq-default which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; Make editing with a shedload of splits easier
(use-package golden-ratio
  :config
  (golden-ratio-mode 1)
  ;; Add evil commands to golden-ratio
  (setq golden-ratio-extra-commands
      (append golden-ratio-extra-commands
              '(evil-window-left
                evil-window-right
                evil-window-up
                evil-window-down
                select-window-1
                select-window-2
                select-window-3
                select-window-4
                select-window-5))))

;; GOD I HATE TABS

(setq-default
 ;; web-mode
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 indent-tabs-mode nil
 ;; css-mode
 css-indent-offset 2
 ;; c-style languages
 c-basic-offset 4)
;; --------------------------- Custom Keybindings --------------------------- ;;

(use-package general
  :config
  (general-define-key
   :states '(normal motion visual emacs)
   :keymaps 'override
   "j" 'evil-next-visual-line
   "k" 'evil-previous-visual-line)
  (general-define-key
   :states '(normal motion visual insert emacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   ;; Main arsenal
   "SPC" '(counsel-M-x
	   :which-key "M-x")
   "/"   '(counsel-rg
	   :which-key "ripgrep-regexp")
   "u"   '(universal-argument
	   :which-key "universal argument")
   ;; Files
   "ff"  '(counsel-find-file
	   :which-key "find files")
   "fr"  '(counsel-recentf
	   :which-key "find recent files")
   "fR"  '((lambda () (interactive)
	     (revert-buffer :ignore-auto :noconfirm))
	   :which-key "reload current buffer from disk")
   "fdd" '(delete-file
	   :which-key "delete file")
   "fdD" '(delete-directory
	   :which-key "delete directory")
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
   "wl"  '(evil-window-right
	   :which-key "move right")
   "wh"  '(evil-window-left
	   :which-key "move left")
   "wk"  '(evil-window-up
	   :which-key "move up")
   "wj"  '(evil-window-down
	   :which-key "move down")
   "wL"  '(evil-window-move-far-right
	   :which-key "move right")
   "wH"  '(evil-window-move-far-left
	   :which-key "move left")
   "wK"  '(evil-window-move-very-top
	   :which-key "move up")
   "wJ"  '(evil-window-move-very-bottom
	   :which-key "move down")
   "wv"  '(split-window-right
	   :which-key "split right")
   "ws"  '(split-window-below
	   :which-key "split below")
   "wd"  '(delete-window
	   :which-key "delete window")
   "wff" '(make-frame
	   :which-key "open new Emacs window")
   "wfd" '(delete-frame
	   :which-key "delete Emacs window")
   ;;Apps
					; Terminal
   "att" '(multi-term
	   :which-key "open terminal")
   "atn" '(multi-term-next
	   :which-key "switch to next term buffer")
   "atp" '(multi-term-prev
	   :which-key "switch to previous term buffer")
					; Org
	   "aot" '(org-todo 
		   :which-key "mark as todo item")
	   "aoT" '(org-todo-list 
		   :which-key "open todo list")
	   "aoi" '(org-display-inline-images 
		   :which-key "show images in .org files")
     "aoc" '(org-clock-in
             :which-key "clock in to track time")
     "Aoc" '(org-clock-out
             :Which-key "clock out to track time")
					; Journal
   "ajj" '(org-journal-new-entry
	   :which-key "new journal entry")
   "ajv" '(org-journal-display-entry 
	   :which-key "view today's journal")
   "ajp" '(org-journal-previous-entry
	   :which-key "view next journal entry")
   "ajn" '(org-journal-next-entry
	   :which-key "view previous journal entry")
   ;; Help
   "hdv" 'counsel-describe-variable
   "hdf" 'counsel-describe-function
   "hdk" 'describe-key
   ;; Comments
   "Cl"  'comment-line
   ;; Complation/Completion
   "cc"  '(completion-at-point
	   :which-key "complete item at point")
   ;; Definitions
   "dg"  '(xref-find-definitions
	   :which-key "goto definition at point")
   "dr"  '(xref-find-references
	   :which-key "find references for symbol at point")
   ;; Toggles
   "tn"  '(display-line-numbers-mode
	   :which-key "toggle line numbers")
   "tw"  '(visual-line-mode
	   :which-key "toggle line wrapping")
   "tg"  '(golden-ratio-mode
           :which-key "toggle golden ratio splits")
   ;; Search (and replace)
   "ss"  '(swiper-all 
	   :which-key "edit matches one-by-one")
   "sS"  '(swiper-multi
	   :which-key "edit matches across files one-by-one")
   ;; Project
   "pp"  '(projectile-switch-project
	   :which-key "open known project")
   "pa"  '(projectile-add-known-project
	   :which-key "add project to list")
   "pA"  '(projectile-discover-projects-in-directory
	   :which-key "discover projects in directory")
   "ps"  '(projectile-ripgrep
	   :which-key "search in project")
   "pf"  '(projectile-find-file
	   :which-key "find files in project")
   ;; Magit
   "gs"  'magit-status
   "gc"  'magit-commit
   "gd"  'magit-diff
   "gt"  'magit-tag
   ;; Colorscheme
   "Ts"  'toggle-dark-light-theme
   ;; Buffers
   "bd"  '(kill-this-buffer
	   :which-key "close buffer")
   "bn"  '(next-buffer
	   :which-key "next buffer")
   "bp"  '(previous-buffer
	   :which-key "previous buffer")
  ;; Insertions
  "is"   '(yas-insert-snippet
           :which-key "insert snippet")))
  ;; Mode-specific keybindings
  ;; (general-define-key
  ;;  :states '(normal motion visual insert emacs)
  ;;  :keymaps 'override
  ;;  :prefix "SPC"
  ;;  :non-normal-prefix "M-SPC"
  ;;  :definer 'minor-mode
  ;;  :keymaps 'org-src-mode
  ;;  "m'"  '(org-edit-special :which-key "edit src block")))

;; ------------------------------ Final Loads ------------------------------- ;;

;; Load all .el files under .emacs.d/config
(load "~/.emacs.d/load-directory.el")
(load-directory "~/.emacs.d/config")

;; Load settings generated by Customize.el
(setq-default custom-file "~/.emacs.d/custom.el")
(load custom-file)
