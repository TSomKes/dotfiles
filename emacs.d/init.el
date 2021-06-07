;; all via this YT playlist:
;; - https://www.youtube.com/playlist?list=PLEoMzSkcN8oPH1au7H6B7bBJ4ZO7BXjSZ

;; TODO:  remap capslock

;; Turn off default start-up page

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			  ("org" . "https://orgmode.org/elpa")
			  ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; ensure this all works even for first-time emacs run on this machine
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; disable side scroll-bar
(tool-bar-mode -1) ; disable graphical tool bar
(tooltip-mode -1) ; disable tooltips

(menu-bar-mode -1) ; disable textual menu bar

(setq visible-bell t) ; enable screen-flash bell, presumably instead of ding

(set-fringe-mode 20) ; add horizontal margins to sides of screen

(load-theme 'tango-dark)

;; Make ESC quit prompts
;; (only needed until Evil mode?)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Key binding magic
(use-package general
  :config ;;(general-evil-setup t)

  (general-create-definer tsomkes/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (tsomkes/leader-keys
    "t" '(:ignore t :which-key "toggles")))

;; Evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual-line j & k motions for line-wrapped lines
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Prefer automatically entering vim's "insert" mode rather than "normal" for some modes.
  (evil-set-initial-state 'messages-buffer-mode 'insert)
  (evil-set-initial-state 'dashboard-mode 'insert))

;; Evil collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Hydra - key binding magic
(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
(tsomkes/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))
  
;; Display cursor's line & column position in bottom bar
(column-number-mode)

;; Enable line numbers...
(global-display-line-numbers-mode 1)
;; ...unless in certain modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(use-package ivy
  :diminish
  :bind (
	 :map ivy-minibuffer-map
	 ("C-k" . ivy-preivous-line)
	 ("C-j" . ivy-next-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 )
  ;; Buncha stuff from the YT video
  :config
  (ivy-mode 1))

;; Try out a different modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
)

;; Rainbow delimiters - make parentheses pop
(use-package rainbow-delimiters
  ;; enable for all programming modes, not just lisp
  :hook (prog-mode . rainbow-delimiters-mode))

;; Which key - provide key-chord-combo hints
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  ;; How long 'til help pops up?
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-buffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  ;; Don't start searches with ^
  (setq ivy-initial-inputs-alist-nil nil))
  

;;: More-helpful Ivy feedback, I guess
;; - counsel feedback (keybindings, descriptions) in ivy lists
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


;; Helpful - more contextual info in help
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Make some fancy themes available
(use-package doom-themes
  :init (load-theme 'doom-tomorrow-night t))

;; Add some nifty project tools.  (e.g. "switch to different project
;; in ~/code")
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
   (when (file-directory-p "~/code")
     (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))

;; Add some fancy counsel functionality to projectile (?)
(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Magit - git magic
(use-package magit)
  ;;:custom
  ;; Don't create new window for diff
  ;;(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fe2539ccf78f28c519541e37dc77115c6c7c2efcec18b970b16e4a4d2cd9891d" default)))
 '(package-selected-packages
   (quote
    (evil-magit magit counsel-projectile projectile hydra evil-collection evil general doom-themes helpful counsel ivy-rich which-key doom-modeline rainbow-delimiters ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
