;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

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
					;(use-package quelpa
					;:ensure t)
					;(quelpa
					;'(quelpa-use-package
					;:fetcher git
					;:url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
					;(require 'quelpa-use-package)

;; Cross over to the VIM DARK SIDE
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
;; Adds `fd` as an evil escape key
(use-package evil-escape
  :ensure t
  :config
  (evil-escape-mode))

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
	ivy-count-format "%d/%d "))

(use-package swiper
  :ensure t)

(use-package counsel
  :ensure t)

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
	   ;; Config
	   "fei" (lambda ()
		    (interactive)
		    (split-window-right)
		    (find-file user-init-file)
		    :which-key "edit init.el")
	   "fer" (lambda ()
		    (interactive)
		    (load-file user-init-file)
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
	   ;; Help
	   "hdv" 'counsel-describe-variable
	   "hdf" 'counsel-describe-function
	   "hdk" 'describe-key
	   ;; Comments
	   "cl"  'comment-line
	   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (counsel-rg counsel swiper evil use-package))))
