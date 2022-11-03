;; ---------------------------------------------------------------------------
;; <Leaf-install-code>
;; ---------------------------------------------------------------------------

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)

  ;; Fix TLS problem on some builds to access package archives
  (custom-set-variables '(gnutls-algorithm-priority "normal:-vers-tls1.3"))

  ;; Add .ghcup to Emacs exec-path
  (setq exec-path (append exec-path '("/home/user/.ghcup/bin")))

  ;; Add .ghcup to environment PATH
  (setenv "PATH" (concat (getenv "PATH") ":/home/user/.ghcup/bin"))
  
  ;; Code for installing leaf
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf use-package :ensure t)

    (leaf vterm :ensure t)
    (leaf neotree :ensure t)
    (leaf company :ensure t)
    (leaf haskell-mode :ensure t)
    (leaf lsp-mode :ensure t)
    (leaf lsp-ui :ensure t)
    (leaf lsp-haskell :ensure t)
    (leaf yaml-mode :ensure t)

    ;; web development
    (leaf web-mode :ensure t)

    ;; Load iceberg-theme BEFORE brin theme 
    ;; https://github.com/conao3/iceberg-theme.el
    (leaf iceberg-theme
      :ensure t
      :config
      (iceberg-theme-create-theme-file))
    ;;(load-theme 'solarized-iceberg-dark t))

    ;; Load brin theme for nicer syntax highlighting
    (leaf sublime-themes
      :ensure t
      :config
      (load-theme 'brin t))
    
    (leaf color-theme-sanityinc-tomorrow :ensure t)
    (leaf color-theme-sanityinc-solarized :ensure t)

    (leaf counsel
      :ensure t
      :config
      ;; Enable ivy completion everywhere
      (ivy-mode 1))

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; ---------------------------------------------------------------------------
;; toggle-maximize-buffer
;; ---------------------------------------------------------------------------

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

;; ---------------------------------------------------------------------------
;; Vue.js
;; ---------------------------------------------------------------------------

;; Install language server
;; M-x lsp-install-server - select vue-semantic-server

;; Required npm packages (global)
;; vue-language-server

;; Required npm packages (project's package.json)
;; "typescript 4.7.4"

;; Issues:
;; https://stackoverflow.com/questions/73957578/
;;         react-test-renderer-cause-typeerror-host-fileexists-is-not-a-function

;; Example:
;; https://azzamsa.com/n/vue-emacs/

(require 'lsp-mode)

(use-package lsp-mode
  :commands lsp)

(use-package web-mode
  :mode "\\.vue\\'"
  :config
  (add-hook 'web-mode-hook #'lsp))

;; Documentation:
;; https://web-mode.org/

(add-to-list 'auto-mode-alist '("\\.vue\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"        . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"    . web-mode))

;; HTML indentation
(setq web-mode-markup-indent-offset 2)
;; CSS indentation
(setq web-mode-css-indent-offset 2)
;; Script idnentation (JavaScript etc.)
(setq web-mode-code-indent-offset 2)
;; Force a fixed indentation
(setq web-mode-attr-indent-offset 2)

;; ---------------------------------------------------------------------------
;; General
;; ---------------------------------------------------------------------------

;; Set js-mode indent level
(setq js-indent-level 2)

;; Start frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; https://www.emacswiki.org/emacs/WinnerMode
;;
;; C-c <left>
;; C-c <right>
(winner-mode 1)
(global-set-key (kbd "C-c <up>") 'toggle-maximize-buffer)

;; Configure recent files hotkey
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Package cl deprecated and being used in haskell-mode package.
;; Disable the warning here.
(setq byte-compile-warnings '(cl-functions))

;; Specify email address
(setq user-email-address "your@email.com")

;; Disable startup screen
(setq inhibit-startup-screen 1)

;; Show file or directory at startup
(setq initial-buffer-choice "~/.")
(cd "~/.")

;; Make Text Mode the default mode for new buffers
(setq-default major-mode 'text-mode)

;; Make sure syntax highlighting is enabled (enable Font Lock minor mode)
(setq global-font-lock-mode t)

;; Set maximum length of message buffer
(setq message-log-max 1000)

;; This function leaves no gaps in the gutter between the line numbers:
;;    (global-linum-mode)
;;
;; This function includes a gap on the left hand side of the line number gutter:
;;    (global-display-line-numbers-mode)
;;
(global-display-line-numbers-mode)

;; Hide tool bar
(tool-bar-mode -1)

;; Have C-n create a new line at the end of a buffer
(setq-default next-line-add-newlines 1)

;; ---------------------------------------------------------------------------
;; Key Bindings
;; ---------------------------------------------------------------------------

;; Navigation
;;
(defun scroll-up-ten-lines ()
  "Scroll up ten lines."
  (interactive)
  (next-line 10))

(defun scroll-down-ten-lines ()
  "Scroll down ten lines."
  (interactive)
  (previous-line 10))

(global-set-key (kbd "C-v") 'scroll-up-ten-lines)
(global-set-key (kbd "M-v") 'scroll-down-ten-lines)

;; Windows
;;
;; https://www.emacswiki.org/emacs/WindMove
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)
(global-set-key (kbd "C-c t") 'vterm) ;; vterm-other-window

;; https://www.emacswiki.org/emacs/WindowResize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key "\C-m" 'newline-and-indent)

;; Copy Line
;; https://www.emacswiki.org/emacs/CopyingWholeLines
;;
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key "\C-c\C-k" 'copy-line)

;; ---------------------------------------------------------------------------
;; Minibuffer
;; ---------------------------------------------------------------------------
;;
;; C-x <ESC> <ESC>
;;   Re-execute a recent minibuffer command from list (repeat-complex-command)
;;
;; M-x list-command-history
;;   Display the entire command history  

;; Minibuffer Electric Mode:
;;   A global minor mode. Emacs hides the default argument as soon as you
;;   modify the contents of the minibuffer. Enabling this minor mode:
;;
(minibuffer-electric-default-mode)

;; Change following variable to non-nil value to display default arguments as
;; (DEFAULT-ARG) instead of (default DEFAULT-ARG) to save some screen space:
(setq minibuffer-eldef-shorten-default t)

;; Set following variable to nil to start the minibuffer as empty:
(setq insert-default-directory t)

;; Allow mini buffer to shrink as lines are removed
;; Only grows by default ('grow-only'). 'nil' disables resizing
(setq resize-mini-window t)

;; Control mini buffer maximum height. Default 0.25
;; Fraction: % of frame's height; Integer: Max number of lines; or nil
(setq max-mini-window-height 0.25)

;; Ignore case when completing file names
(setq read-file-name-completion-ignore-case t)

;; Do not ignore case when completing buffer names
(setq read-buffer-completion-ignore-case nil)

;; Max length of history buffers (file names, commands, buffer names lists,
;; etc). Default value is 100.
(setq history-length 120)

;; Do not delete duplicates in history lists
(setq history-delete-duplication nil)

;; ---------------------------------------------------------------------------
;; Mode Line
;; ---------------------------------------------------------------------------

;; Turn on Line Number
(setq-default line-number-mode 1)

;; Display size of buffer
(setq-default size-indication-mode 1)

;; ---------------------------------------------------------------------------
;; Point Behavior
;; ---------------------------------------------------------------------------

;; Point treats continued lines as logical lines ('track-eol' variable related)
(setq-default line-move-visual 1)

;; Display help text in echo area when pointer is over an item
(setq help-at-pt-display-when-idle t)

;; ---------------------------------------------------------------------------
;; Killing, Yanking and Kill Ring
;; ---------------------------------------------------------------------------
;;
;; C-h v kill-ring    View contents of the kill ring
;; C-y  M-y           Yank and cycle through kill ring

;; Set max items in kill ring (default 60)
(setq kill-ring-max 70)

;; Emacs transfers data to a program called the clipboard manager from the
;; clipboard when exiting. Set the following variable to 'nil' to disable
;; this, which will speed up closing Emacs:
(setq x-select-enable-clipboard-manager nil)

;; Enable the clipboard. Set to 'nil' to prevent kill/yank commands accessing
;; the clipboard.
(setq select-enable-clipboard t)

;; Make tabs use spaces only to indent lines
(setq-default indent-tabs-mode nil)

;; ---------------------------------------------------------------------------
;; Theming
;; ---------------------------------------------------------------------------
;;
;; Docmentation:
;; https://www.emacswiki.org/emacs/ColorThemes
;;
;; Preview color themes with the following command:
;;   M-x color-theme-select
;;
;; Customize theme through GUI (default to set font)
;;   M-x customize-face

;; Add emacs folder to load path (removed)
;; (add-to-list 'load-path "~/.emacs.d/packages")

;; Highlight the current line
;;     (require 'hl-line)
;; Customize hl-line:
;;     M-x customize-group RET hl-line
;;
(global-hl-line-mode)

;; Disable bold font globally
(mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal))
   (face-list))

;; Disable italics globally:
;;   M-x eshell
;;   $ (set-face-italic 'font-lock-comment-face nil)

;; ---------------------------------------------------------------------------
;; Custom Faces
;; ---------------------------------------------------------------------------

;; Customize mode-line colors:
;;     M-x customize-group RET mode-line-faces
;;
;; Customize company popup:
;;     M-x customize-group RET company -> Company Faces

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "gray12" :foreground "#c0c5ce" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "CTDB" :family "Fira Code"))))
 '(ansi-color-blue ((t (:background "deep sky blue" :foreground "deep sky blue" :weight normal))))
 '(company-tooltip ((((class color) (min-colors 89)) (:foreground "#767781" :background "#1a1c25"))))
 '(company-tooltip-annotation ((((class color) (min-colors 89)) (:foreground "#89b8c2"))))
 '(company-tooltip-annotation-selection ((((class color) (min-colors 89)) (:foreground "#89b8c2"))))
 '(company-tooltip-common ((((class color) (min-colors 89)) (:foreground "#6b6d76"))))
 '(company-tooltip-common-selection ((((class color) (min-colors 89)) (:weight bold))))
 '(company-tooltip-selection ((t (:background "#40525c" :weight normal))))
 '(hl-line ((t (:inherit highlight :extend t :background "#24262f"))))
 '(line-number ((t (:inherit (shadow default) :foreground "gray20"))))
 '(line-number-current-line ((t (:inherit default :foreground "grey38"))))
 '(mode-line ((((class color) (min-colors 89)) (:foreground "#babcc5" :background "gray4"))))
 '(mode-line-inactive ((((class color) (min-colors 89)) (:foreground "#6b6d76" :background "gray4")))))

;; ---------------------------------------------------------------------------
;; Selected Packages
;; ---------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" default))
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(haskell-hasktags-arguments ''("-e" "-x"))
 '(haskell-mode-hook '(haskell-indentation-mode))
 '(haskell-stylish-on-save nil)
 '(lsp-haskell-formatting-provider "stylish-haskell")
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(yaml-mode perspective project use-package lsp-haskell company leaf haskell-mode)))

;; ---------------------------------------------------------------------------
;; Haskell Mode
;; ---------------------------------------------------------------------------
;;
;; Use M-x customize-group RET haskell to browse the haskell customization
;; subtree.
;;
;; You should customize the 'haskell-mode-hook' variable which gets run right
;; after the 'haskell-mode' major mode is initialized for a buffer. Customise
;; by running 'M-x customize-variable RET haskell-mode-hook'.

;; Hooks so haskell and literate haskell major modes trigger LSP setup.
(require 'lsp)
(require 'lsp-haskell)

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

;; F7 toggles lsp-lens-mode
(add-hook 'haskell-mode-hook
          (lambda () (local-set-key [f7] 'lsp-lens-mode)))

;;(add-hook 'haskell-mode-hook
;;          (lambda ()
;;            ;; 'haskell-navigate-imports' moves cursor to import list.
;;            (define-key haskell-mode-map (kbd "f9") 'haskell-navigate-imports)))

(setq lsp-haskell-process-path-hie "ghcide")
(setq lsp-haskell-process-args-hie '())

;; ---------------------------------------------------------------------------
;; Haskell Tags
;; ---------------------------------------------------------------------------
;; https://github.com/MarcWeber/hasktags

;; Generate tags when saving using external program Hasktags
(setq haskell-tags-on-save t)

;; Revert tags tables automatically (reread TAGS table without querying)
(setq tags-revert-without-query t)

;; ---------------------------------------------------------------------------
;; Completion Support
;; ---------------------------------------------------------------------------

;; haskell-mode completes identifiers (symbols) using tags. However, you can get
;; more precise completions with 'haskell-interactive-mode', where completion
;; candidates are produced by querying GHCi REPL.

;; Enable company mode with 'M-x company-mode'
;; Use company-mode in all buffers:
(add-hook 'after-init-hook 'global-company-mode)

;; ---------------------------------------------------------------------------
;; lsp-ui
;; ---------------------------------------------------------------------------

;; Guide on enabling and disabling features:
;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/

(use-package lsp-ui)

;; https://github.com/flycheck/flycheck
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-position "at-point")
(setq lsp-ui-doc-delay 0.1)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse t)

;; modeline
(setq lsp-modeline-code-actions-enable t)
(setq lsp-modeline-diagnostics-enable nil)

(setq lsp-diagnostics-provider :flymake)
(setq lsp-ui-sideline-enable t)
(setq lsp-modeline-diagnostics-enable t)

;; ---------------------------------------------------------------------------
;; yaml-mode
;; ---------------------------------------------------------------------------

;; Required for Haskell indentation to work:
;; https://www.emacswiki.org/emacs/YamlMode
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; ---------------------------------------------------------------------------
;; Vterm
;; ---------------------------------------------------------------------------
;; https://github.com/akermu/emacs-libvterm
;;
;; Requirements:
;;   module-file-suffix is not nil
;;   cmake (>=3.11)
;;   libtool-bin
;;   libvterm (optional)
;;
;; Installing libtool-bin and libvterm on Arch:
;;   sudo pacman -S libtool libvterm 

;; Instruct vterm to use a fixed-pitch (mono-spaced) font
(add-hook 'vterm-mode-hook
          (lambda () 
            (set (make-local-variable 'buffer-face-mode-face) 'fixed-pitch)
                 (buffer-face-mode t)))

;; ---------------------------------------------------------------------------
;; Neotree
;; ---------------------------------------------------------------------------
;; https://www.emacswiki.org/emacs/NeoTree
;; https://github.com/jaypei/emacs-neotree
;;
(global-set-key [f8] 'neotree-toggle)

;; n, p             next line, previous line
;; SPC, RET, TAB    open current item if a file. fold/unfold a directory
;; U                go up a directory
;; g                refresh
;; A                maximize/minimize neotree window
;; H                toggle display hidden files
;; O                recursively open a directory
;; C-c C-n          create a file or directory if name ends in /
;; C-c D-d          delete a file or directory
;; C-c C-r          rename a directory
;; C-c C-c          change root directory
;; C-c C-p          copy a file or directory

;; Neotree themes: classic (default) ascii arrow icons nerd
;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;;
;; TODO: Install all-the-icons package to enable icons theme
;;  https://github.com/domtronn/all-the-icons.el
;;
(setq neo-theme 'nerd)

;; Every time neotree is opened, jump to the current file.
(setq neo-smart-open t)

;; ---------------------------------------------------------------------------
;; project.el
;; ---------------------------------------------------------------------------
;; Install via the following commands;
;;   M-x package-list-packages
;;   <put cursor over project>
;;   <RET> to install
;;
;; View available commands to manage projects:
;;   C-x p C-h 

;; -------------------------------------------------------------------
;; Ivy 
;; -------------------------------------------------------------------
;; (https://oremacs.com/swiper/)

;; Enable ivy completion everywhere (in leaf config)
;;(ivy-mode 1)

;; Key bindings for navigation
;; C-n   (ivy-next-line) selects the next candidate
;; C-p   (ivy-previous-line) selects the previous candidate
;; M-<   (ivy-beginning-of-buffer) selects the first candidate
;; M->   (ivy-end-of-buffer) selects the last candidate
;; C-v   (ivy-scroll-up-command) scrolls up by ivy-height lines
;; M-v   (ivy-scroll-down-command) scrolls down by ivy-height lines

;; Basic settings
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d%d) ")

;; Ivy-based interface to standard commands
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)

(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

(global-set-key (kbd "C-c t") 'counsel-load-theme)

;; -------------------------------------------------------------------
;; ORG MODE
;; -------------------------------------------------------------------
;; Requires Font Lock mode: turn-on-font-lock

;; Suggested bindings for popular commands
;;
(global-set-key (kbd "C-c l") 'org-store-link)
;;(global-set-key (kbd "C-c a") 'org-agenda)
;;(global-set-key (kbd "C-c c") 'org-capture)

;; Make a file load org mode by adding:
;; MY PROJECTS    -*- mode: org; -*-
;;
;; Or set variable: org-insert-mode-line-in-empty-file

;; Number of empty lines needed to keep an empty line between
;; collapsed trees.
(setq org-cycle-separator-lines 2)

;; Show everything on startup in an org document.
;; Or add to files individually:
;;     #+STARTUP: overview | content | showall | showeverything
;;
;; Any entries with `VISIBILITY` property get their visibility adapted accordingly.
;; Allowed values: `folded | children | content | all`
;;
(setq org-startup-folded 'show-everthing)

;; Define TODO keyword sequences 
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING" "|" "DONE(d)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))

;; Record timestap when closing a TODO item.
;; To record a note along with a timestamp:
;;     (setq org-log-done 'note)
;;
(setq org-log-done 'time)

;; ---------------------------------------------------------------------------
;; Custom Function (Elisp reference)
;; ---------------------------------------------------------------------------

;; yaml-mode installed via:
;; M-x package-install

(defun check-and-install-packages (symbol-list)
  "Check if packages list is Installed and install if necessary"
  (setq install-list ())                             ;; Variable to hold uninstalled items

  ;; Construct install list
  (while symbol-list
    (setq item (car symbol-list))                    ;; Get first item in list
    (if (not (package-installed-p item))             ;; Check if item is installed
        (progn (message "Not Installed: %s"
                        (symbol-name item))
               (push (make-symbol                    ;; Add item to install list
                      (symbol-name item))
                      install-list))
      (message "Already Installed: %s"
               (symbol-name item)))                  ;; End-if
    (setq symbol-list (cdr symbol-list)))            ;; Truncate list
  (message "To Install: %s" install-list)            ;; Display install list

  ;; Install items
  (when install-list                                 ;; If there are packages to install
    (package-refresh-contents)                       ;; Download latest ELPA package info
    (while install-list
      (progn (setq item (car install-list))              ;; Get next item to install
             (package-install item)                      ;; Install item
             (setq install-list (cdr install-list))))))  ;; Truncate list


