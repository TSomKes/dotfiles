(require 'package)

;; Set up package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Grab package info if missing
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Disable that fresh-install block of text
(setq inhibit-startup-message t)

;; Disable GUI stuff
(scroll-bar-mode -1) ; disable side scroll-bar
(tool-bar-mode -1) ; disable graphical tool bar
(tooltip-mode -1) ; disable tooltips

;; Add horizontal margins ("gutters"?) to sides of window
(set-fringe-mode 20) 

;; Disable top menu bar
(menu-bar-mode -1)

;; Enable screen-flash bell (presumably instead of ding?)
(setq visible-bell t) 

;; Display cursor's line & column position in bottom bar
(column-number-mode)

;; Enable line numbers...
(global-display-line-numbers-mode 1)
;; ...unless in certain modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Make ESC quit prompts (still necessary w/Evil mode?)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; general.el provides keybinding binding magic
(use-package general
  :after evil
  :config
  ;; Inspired by spacemacs, add some spacebar-prefix spice
  (general-create-definer tsomkes/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (tsomkes/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t) ; NOTE: this is where I'm playing with vim/Evil TAB behavior
  (setq evil-undo-system 'undo-fu)
  ;; Make vim *, etc. respect underscores in function/variable names
  ;; via https://emacs.stackexchange.com/questions/9583/how-to-treat-underscore-as-part-of-the-word
  (setq evil-symbol-word-search t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-motion-state-map (kbd "RET") nil) ; Trying to free up RET for org link-following behavior

  ;; Use visual-line j & k motions for line-wrapped lines
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Prefer automatically entering vim's "insert" mode rather than "normal" for some modes.
  (evil-set-initial-state 'messages-buffer-mode 'insert)
  (evil-set-initial-state 'dashboard-mode 'insert)
  (evil-set-initial-state 'deft-mode 'insert))

;; Evil collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra
  :defer t)

;; Make a scale-text-bigger/smaller function to demo Hydra
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(tsomkes/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; doom-themes - fancy doom-emacs themes
(use-package doom-themes
  :init (load-theme 'doom-tomorrow-night t))

;; I haven't tried this yet, but it looks verr fancy.
;; (use-package all-the-icons)

;; Try out a different modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :defer 0
  :config
  (which-key-mode)
  ;; How long 'til help pops up?
  (setq which-key-idle-delay 0.5))

(use-package ivy
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-k" . ivy-previous-line)
         ("C-j" . ivy-next-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         )
  :config
  (ivy-mode 1))

;; More contextual info in Ivy
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;(prescient-persist-mode 1) ; persist prescient data across sessions
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Since we've made org-mode variable-width-font by default, specify
;; some fixed-width regions
(defun tsomkes/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; All org-mode is set to default to variable-width font; make sure fixed-width stuff works correctly
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

;; Change org bullet style to be more circle-y
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  ;; Replace stars, flowers, etc.
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Give org mode docs some left & right margin
;; ...not sure I like this.
;(defun tsomkes/org-mode-visual-fill ()
;  (setq visual-fill-column-width 100
;	visual-fill-column-center-text t)
;  (visual-fill-column-mode 1))
;
;(use-package visual-fill-column
;  :hook (org-mode . tsomkes/org-mode-visual-fill))

(defun tsomkes/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . tsomkes/org-mode-setup)
  :config
  (setq org-ellipsis " ▼") ; Replace code-folding elipses
  (setq org-return-follows-link t) ; RET key opens org-mode links

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; Different orgfiles paths depending on OS
  (setq org-directory
        (cond ((string-equal system-type "gnu/linux") "~/orgfiles/")
              ((string-equal system-type "windows-nt") "D://Dropbox//Dropbox//orgfiles//")))

  (setq org-agenda-files (directory-files-recursively (concat org-directory "agenda/") "\\.org$"))

  (global-set-key (kbd "C-C l") 'org-store-link)
  (global-set-key (kbd "C-C a") 'org-agenda)
  (global-set-key (kbd "C-C c") 'org-capture)

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  ;; Buncha "todo" states defined by this dude.  I might want to keep,
  ;; change, or ditch.
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)"
                    "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)"
                    "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("archive.org" :maxlevel . 2)
          ("tasks.org" :maxlevel . 1)))

  ;; Save org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))
          ))
  ;; ... he has others, too.

  (defun TSomKes/capture-new-project-file ()
    (let ((name (read-string "Filename: ")))
      (expand-file-name (format "%s.org" name) (expand-file-name "projects/" org-directory))))

  (setq org-capture-templates
        `(("n" "Note" entry (file+olp "agenda/inbox.org" "Inbox") "\n* %?\n" :empty-lines 1)
          ("t" "Tasks")
          ("tt" "Task" entry (file+olp "agenda/tasks.org" "Inbox") "* TODO %?\n %U\n %a\n %i" :empty-lines 1)
          ("j" "Journal Entries")
          ("jj" "Journal" entry (file+olp "journal/journal.org") "\n* %<%I:%M %p> :journal:\n%?\n")
          ("p" "Project" entry (file TSomKes/capture-new-project-file) "* %?")
          ("m" "Metrics Capture")
          ("mw" "Weight" table-line (file+olp "journal/metrics.org" "Weight") "| %U | %^{weight} |" :kill-buffer t)))
  ;; ... he has others, too.

  (defun tsomkes/toggle-org-emphasis-chars ()
    "Toggle visibility of org-mode emphasis characters."
    (interactive)
    (if org-hide-emphasis-markers
        (set-variable 'org-hide-emphasis-markers nil)
      (set-variable 'org-hide-emphasis-markers t))
    (org-mode-restart))

  (tsomkes/leader-keys
    "te" '(tsomkes/toggle-org-emphasis-chars
           :which-key "org emphasis characters")
    "tl" '(org-toggle-link-display
           :which-key "org links"))

  (tsomkes/org-font-setup)

  ;; By default drop notes into Brain, and open Brain when starting Emacs
  (setq org-default-notes-file (concat org-directory "agenda/brain.org")
        initial-buffer-choice org-default-notes-file))

;; Trying this org-roam thing on my own...
(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory (file-truename (concat org-directory "roam")))
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert)
               ("C-c n I" . org-roam-insert-immediate)))
  :config
  (setq org-roam-capture-templates
        `(("d" "default" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+title: ${title}\n"
           :unnarrowed t)
          ("s" "source" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "sources/${slug}"
           :head "#+title: ${title}\n"
           :unnarrowed t)
          ("t" "topic" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "topics/${slug}"
           :head "#+title: ${title}\n"
           :unnarrowed t))))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
;     (php . t)
     (python . t)))

  ;; Not sure where this falls on the demo...useful spectrum.
  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("php" . "src php"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

;; Automatically tangle emacs_init.org config file when we save it
(defun tsomkes/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name (concat org-directory "emacs_init.org")))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'tsomkes/org-babel-tangle-config)))

(use-package deft
  :after org
  :bind ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org-roam-directory))

(use-package projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

;; Magit - git magic
(use-package magit
  :commands magit-status)

(use-package rainbow-delimiters
  ;; enable for all programming modes, not just lisp
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package undo-fu
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))


