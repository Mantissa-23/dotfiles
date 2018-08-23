 ;; option for enabling vi keys in the minibuffer
     ;; Addresses evil-core.el:163 TODO

(mapcar (lambda (keymap)
	  (evil-define-key 'insert (eval keymap) [escape] 'abort-recursive-edit)
	  (evil-define-key 'normal (eval keymap) [escape] 'abort-recursive-edit)
	  (evil-define-key 'insert (eval keymap) [return] 'exit-minibuffer)
	  (evil-define-key 'normal (eval keymap) [return] 'exit-minibuffer)
	  (evil-define-key 'insert (eval keymap) "\C-t" 'evil-normal-state)
	  )
	;; https://www.gnu.org/software/emacs/manual/html_node/elisp/
	;; Text-from-Minibuffer.html#Definition of minibuffer-local-map
	'(minibuffer-local-map
	  minibuffer-local-ns-map
	  minibuffer-local-completion-map
	  minibuffer-local-must-match-map
	  minibuffer-local-isearch-map))

(add-hook 'minibuffer-setup-hook 
	  '(lambda () 
	     (set (make-local-variable 'evil-echo-state) nil)
	     ;; (evil-set-initial-state 'mode 'insert) is the evil-proper
	     ;; way to do this, but the minibuffer doesn't have a mode.
	     ;; The alternative is to create a minibuffer mode (here), but
	     ;; then it may conflict with other packages' if they do the same.
	     (evil-insert 1)))
