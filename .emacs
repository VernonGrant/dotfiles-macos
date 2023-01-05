;;; package --- .emacs
;;; Commentary:
;;
;; General:
;; Keyboard shortcut reminders can be found here:
;; https://github.com/VernonGrant/emacs-keyboard-shortcuts

;;; Code:

;;;;;;;;;;;
;; Melpa ;;
;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; fetch the list of packages available.
(unless package-archive-contents
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable bell.
(setq-default visible-bell nil)
(setq-default ring-bell-function 'ignore)

;; Show matching parenthesis.
(show-paren-mode 1)

;; Remove GUI menus and scroll bars.
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Encoding.
(setq-default buffer-file-coding-system 'utf-8-unix)

;; Tab width.
(setq-default tab-width 4)

;; Disable line wrapping.
(set-default 'truncate-lines -1)

;; Enable delete region selection deletion.
(delete-selection-mode 1)

;; Show column and line numbers
(setq-default column-number-mode t)

;; Show clock in mode line.
(display-time)

;; Mark ring settings.
(setq-default set-mark-command-repeat-pop t)
(setq-default global-mark-ring-max 16)
(setq-default mark-ring-max 8)

;; Save backup files to specific folder.
(setq-default backup-directory-alist `(("." . "~/.emacs-saves")))

;; Set the tramp mode. /ssh:Name:path.
(setq-default tramp-default-method "ssh")

;; Trim whitespaces on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Toggle saving of minibuffer history (Savehist mode).
(savehist-mode 1)

;; Automatically save bookmarks in custom file.
(setq-default bookmark-save-flag 1)

;; Minibuffer settings.
(setq-default resize-mini-windows t)
(setq-default max-mini-window-height 1) ;; Limit the minibuffer height.

;; Highlight current line.
(global-hl-line-mode t)

;; Line numbers
(global-display-line-numbers-mode)
;; (setq-default display-line-numbers-type 'relative)

;; Unbind the most annoying thing ever.
(define-key global-map (kbd "C-z") nil)

;; Recentf settings
(require 'recentf)

;; Change the recentf file path.
(setq-default recentf-save-file
              (recentf-expand-file-name
               "~/.emacs-recentf"))

(recentf-mode 1)
(setq-default recentf-max-menu-items 500)
(setq-default recentf-max-saved-items 500)
;; (run-at-time "10 min" 600 'recentf-save-list)

;; Open recentf in other window
(setq-default switch-to-buffer-obey-display-actions t)
(add-to-list 'display-buffer-alist
             '("^\\*Open Recent\\*" display-buffer-reuse-window
                                     (inhibit-same-window . t)))

;; PHP mode settings.
(setq-default php-mode-template-compatibility nil)

;; Flyspell.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Move deleted files to trash.
(setq-default delete-by-moving-to-trash t)

;; Automatically load .dir-locals.
(defun safe-local-variable-p (sym val)
  "Automatically load .dir-locals.
SYM:
VAL:"
  t)

;; Prevent mouse click pasting clipboard into Emacs.
(setq-default x-select-enable-primary nil)

;; Org mode
(setq-default org-agenda-window-setup 'current-window)

;; Automatically reload changed files.
(global-auto-revert-mode t)

;; Globally enable abbrev
(setq-default abbrev-mode t)

;; Enable whitespaces everywhere
;; (global-whitespace-mode)
(setq-default whitespace-line-column 80)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-indent 4)
(setq-default tab-width 4)

;; Windmove, just for GDB layout.
(windmove-default-keybindings 'meta)

;; Automatically resize splits.
(setq window-combination-resize t)

;; Fill column ruler.
(setq-default fill-column 80)
(setq-default display-fill-column-indicator-character 124)
(global-display-fill-column-indicator-mode)

;; Grep settings.
(setq-default grep-use-null-device nil)

;; Ibuffer.
(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-auto-mode 1)))

;; Use OSX based system font.
(if (eq system-type 'darwin)
    (set-face-attribute 'default nil
                        :family "Menlo" :height 145 :weight 'normal))

;; Use Windows based system font.
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas" :height 100))

;; Use Linux based system font.
(if (eq system-type 'gnu/linux)
    (set-face-attribute 'default nil :family "Monospace" :height 110))

;; Moves Emacs customization to separate file.el
(setq custom-file (concat user-emacs-directory ".emacs-custom.el"))
(load custom-file 'noerror)

;; Add NVM's node path.
(setq-default exec-path (append exec-path '("~/.nvm/versions/node/v18.12.1/bin")))

;;;;;;;;;;;;;;;
;; I Do Mode ;;
;;;;;;;;;;;;;;;

(setq-default ido-enable-flex-matching t)
(setq-default ido-everywhere t)
(setq-default ido-auto-merge-work-directories-length -1)
(ido-mode 1)

;;;;;;;;;;;;;;;;;;
;; Ubuntu XClip ;;
;;;;;;;;;;;;;;;;;;

;; For Ubuntu Xclip (sudo apt install xclip)
(use-package xclip
  :ensure t
  :init
  (custom-set-variables '(x-select-enable-clipboard t))
  (custom-set-variables '(select-enable-clipboard t))
  (xclip-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WL-Clipboard integration (Wayland/TMUX) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; credit: yorickvP on GitHub
;; (setq wl-copy-process nil)

;; (defun wl-copy (text)
;;   (setq wl-copy-process (make-process :name "wl-copy"
;;                                       :buffer nil
;;                                       :command '("wl-copy" "-f" "-n")
;;                                       :connection-type 'pipe))
;;   (process-send-string wl-copy-process text)
;;   (process-send-eof wl-copy-process))

;; (defun wl-paste ()
;;   (if (and wl-copy-process (process-live-p wl-copy-process))
;;       nil ; should return nil if we're the current paste owner
;;     (shell-command-to-string "wl-paste -n | tr -d \r")))

;; (setq interprogram-cut-function 'wl-copy)
;; (setq interprogram-paste-function 'wl-paste)

;;;;;;;;;;;;;;;;;
;; Think Theme ;;
;;;;;;;;;;;;;;;;;

;; Loading of theme.
(setq-default custom-theme-load-path '("~/.emacs-themes"))
(load-theme 'think t)

;; Make it transparent if we're in the terminal.
(defun on-after-init ()
    (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; Make things transparent.
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;

(eval-when-compile
  ;; Automatically install use-package if needed.
  (unless (require 'use-package nil 'noerror) (package-install 'use-package))
  (require 'use-package))

(use-package markdown-mode :ensure t)
(use-package json-mode :ensure t)
(use-package typescript-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package php-mode :ensure t)
(use-package clojure-mode :ensure t)
(use-package cider :ensure t)
(use-package git-modes :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package powershell  :ensure t)
(use-package glsl-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode)))

(use-package magit
  :ensure t
  :bind (("C-c g l" . magit-log-current)
         ("C-c g g" . magit-status)
         ("C-c g P" . magit-pull)
         ("C-c g p" . magit-push)
         ("C-c g f" . magit-fetch)
         ("C-c g s" . magit-stash)
         ("C-c g c" . magit-checkout)))

(use-package editorconfig
  :ensure t
  :init
  :config
  (editorconfig-mode 1)
  ;; Fixes code indentation directly under php tags.
  (add-hook 'editorconfig-after-apply-functions
            (lambda (hash) (setq-default web-mode-block-padding 0))))

(use-package web-mode
  :ensure t
  :config
  (setq-default web-mode-enable-auto-expanding nil)
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode)))

(use-package yasnippet
  :ensure t
  :config
  (setq-default yas-snippet-dirs '("~/.emacs-snippets"))
  (yas-reload-all)
  :init
  (yas-global-mode 1))

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (setq-default company-format-margin-function nil)
  (setq-default company-minimum-prefix-length 2)
  (setq-default company-idle-delay .4)
  :bind (("C-c y" . company-yasnippet)
         ("C-c C-SPC" . company-complete)
         (:map company-active-map ("TAB" . company-complete-selection))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code intellisense setup ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I had a weird issue of language servers not working, running the following
;; inside the ~/.emacs.d/elpa/ folder helped:
;; find . -type f -name '*.elc' -delete
(defun vg-lsp-mode-install-update-servers()
  "Install or update my required LSP servers."
  (interactive)
  ;; YAML
  (lsp-update-server 'yamlls)
  ;; JSON, HTML, CSS, Markdown
  (lsp-update-server 'html-ls)
  ;; C, C++ (Install clang(d) via the package manager
  ;; PowerShell
  (lsp-update-server 'pwsh-ls)
  ;; Docker
  (lsp-update-server 'dockerfile-ls)
  ;; Emmet
  (lsp-update-server 'emmet-ls)
  ;; XML
  (lsp-update-server 'xmlls)
  ;; Bash
  (lsp-update-server 'bash-ls)
  ;; Clojure (Install via home-brew Linux)
  ;; PHP Intelephense
  (shell-command "npm install -g intelephense")
  ;; JavaScript & Typescript
  (shell-command "npm install -g typescript-language-server typescript"))

(defun vg-lsp-mode-configure-servers()
  "Configure each server."
  ;; Clojure
  (setq-default lsp-clojure-custom-server-command "/opt/homebrew/bin/clojure-lsp")
  ;; C/C++
  (setq-default
   lsp-clangd-binary-path "/usr/bin/clangd")
  ;; PHP
  (setq-default
   lsp-intelephense-telemetry-enabled nil
   lsp-intelephense-format-enable nil
   lsp-intelephense-licence-key   (with-temp-buffer
                                    (insert-file-contents "~/.emacs-intelephense-license")
                                    (buffer-string))
   ))

;; LSP-MODE:
;;
;; Performance Tip:
;;
;; LSP-Mode can be compiled in 2 modes plist and hash-table based lsp-use-plists
;; flag. plists provide better performance in deserialization and also put less
;; presure than hash-tables. To switch to plist you have set the
;; environment. variable LSP_USE_PLISTS=true.
;;
;; You can test this using: (getenv "LSP_USE_PLISTS"), should return true.
;;
;; Binding Reminders:
;;
;; C-c l = = | Ask the server to format this document.
;; C-c l h h | Display the type signature and documentation of the thing at point.
;; C-c l g g | Find definitions of the symbol under point.
;; C-c l g r | Find references of the symbol under point.
;; C-c l g a | Find all meaningful symbols that match pattern.
;; C-c l r r | Rename the symbol (and all references to it).
(use-package lsp-mode
  :ensure t
  :init
  ;; Performance changes.
  (setq-default
   lsp-enable-snippet t
   lsp-enable-suggest-server-download nil
   lsp-file-watch-threshold 1000
   lsp-headerline-breadcrumb-enable nil
   lsp-idle-delay 0.500
   lsp-keep-workspace-alive nil
   lsp-keymap-prefix "C-c C-l"
   lsp-lens-enable nil
   lsp-log-io nil
   lsp-use-plists  "true"
   lsp-eldoc-render-all t
   lsp-eldoc-enable-hover t
   lsp-ui-sideline-enable t
   lsp-ui-sideline-show-hover nil
   lsp-ui-doc-enable nil)
  :config
  (vg-lsp-mode-configure-servers)
  :commands (lsp lsp-deferred)
  ;; Manually enable the language server when needed.
  :bind
  ("C-c l l" . lsp-mode))

;; Language server user interface.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Install the latest version of xref.
(use-package xref :ensure t)

;; Setup of linters.
(use-package flycheck
  :ensure t
  :hook
  (c-mode . flycheck-mode)
  (clojure-mode . flycheck-mode)
  (css-mode . flycheck-mode)
  (emacs-lisp-mode . flycheck-mode)
  (js-mode . flycheck-mode)
  (json-mode . flycheck-mode)
  (php-mode . flycheck-mode)
  (shell-script-mode . flycheck-mode)
  (web-mode . flycheck-mode)
  (yml-mode . flycheck-mode)
  (texinfo-mode . flycheck-mode)
  :config
  ;; Controls how the errors buffer is displayed.
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.2)))

  ;; Disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers '(javascript-jshint)))
  (flycheck-add-mode 'php-phpcs 'php-mode)
  (flycheck-add-mode 'php-phpcs 'web-mode)
  (setq-default flycheck-checker-error-threshold 100))

;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun vg-get-project-root()
  "Get's a projects root directory if found.
Tries to find the .git folder or a .dirlocals.el file and basis the projects
root on that."
  (let ((dirlocals-file (locate-dominating-file default-directory ".dir-locals.el"))
        (git-folder (locate-dominating-file default-directory ".git")))
    ;; Return git folder if found.
    (when git-folder
      git-folder)
    ;; Return dirlocals path if found.
    (when dirlocals-file
      dirlocals-file)
    ;; Can't find root, just return the default directory.
    (expand-file-name default-directory)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interactive Functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun vg-insert-rss-timestamp()
  "Insert the current data time stamp in the format of RFC-822."
  (interactive)
  (insert (format-time-string "%a, %d %b %Y %T %z")))

(defun vg-insert-sitemap-timestamp()
  "Insert the current data time stamp in the format of W3C."
  (interactive)
  (insert (format-time-string "%FT%T%z"))
  (backward-char 2)
  (insert ":")
  (forward-char 2))

(defun vg-duplicate-line()
  "Duplicate the current line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))

(defun vg-async-shell-command-no-window (command)
  "Run the provided command in the background.
COMMAND: The shell command."
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(defun vg-org-agenda-list-other-window()
  "Open org agenda list in other window."
  (interactive)
  ;; Duplicate current buffer in other window.
  (switch-to-buffer-other-window (buffer-name))
  (org-agenda-list))

(require 'hi-lock)
(defun vg-toggle-mark-word-at-point()
  "Highlight the things at point."
  (interactive)
  (if hi-lock-interactive-patterns
      (unhighlight-regexp (car (car hi-lock-interactive-patterns)))
    (highlight-symbol-at-point)))
(global-set-key (kbd "C-c hh") 'vg-toggle-mark-word-at-point)

(defun vg-locate-project-file()
  "Call locate with the current projects root path being the filter."
  (interactive)
  (let ((match (read-string "Locate: ")))
    (locate-with-filter match (vg-get-project-root))))

(defun xah-insert-random-number (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
URL `http://xahlee.info/emacs/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890" )
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 13 ))
      (insert (elt $charset (random $baseCount))))))

(defun vg-change-line-endings-unix ()
  "Change line endings of current buffer from DOS to Unix.
CREDIT: https://github.com/rduplain"
  (interactive)
  (set-buffer-file-coding-system 'unix)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun vg-change-line-endings-dos ()
  "Change line endings of current buffer from Unix to DOS.
CREDIT: https://github.com/rduplain"
  (interactive)
  (set-buffer-file-coding-system 'dos)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP Development Helpers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcustom vg-php-lsp-use-phpcs
  nil "Use phpcs instead of lsp checker." :type '(boolean))

(defcustom vg-php-phpcbf-format-on-save
  nil "Auto format the PHP file before save." :type '(boolean))

(defun vg-phpcbf-format-current-file()
  "Will check if a phpcbf formatter is available.
Will use that to format the active PHP file."
  (interactive)
  (let ((dirlocals-file
		 (locate-dominating-file default-directory ".dir-locals.el")))
	(if dirlocals-file
		(let ((phpcbf-file (concat dirlocals-file "vendor/bin/phpcbf")))
		  (if (file-exists-p phpcbf-file)
			  (if (string= (file-name-extension (buffer-file-name)) "php")
				  (let ((phpcbf-cmd (concat phpcbf-file " -"))
						(cursor-line (line-number-at-pos))
						(cursor-column (current-column)))
					(shell-command-on-region
					 (point-min) (point-max) phpcbf-cmd t (buffer-name))
					(goto-line cursor-line)
					(move-to-column cursor-column t)
                    (recenter-top-bottom))
				(message (file-name-extension (buffer-file-name))))
			(message "PHPCBF file not found: %s" phpcbf-file)))
	  (message "Dir-locals file not found: %s" dirlocals-file))))

(defun vg-php-before-save-actions()
  "Run a series of tools on the current PHP file, before save."
  ;; Automatically format PHP file using PHPCBF.
  (when (string= (file-name-extension (buffer-file-name)) "php")
    (when vg-php-phpcbf-format-on-save
      (vg-phpcbf-format-current-file))))
(add-hook 'before-save-hook 'vg-php-before-save-actions)

(defun vg-php-set-local-bindings()
  "Set bindings based on file extensions, when using web-mode."
  (interactive)
  (if (string= (file-name-extension (buffer-file-name)) "php")
      (local-set-key (kbd "C-c =") 'vg-phpcbf-format-current-file)))
(add-hook 'php-mode-hook 'vg-php-set-local-bindings)
(add-hook 'web-mode-hook 'vg-php-set-local-bindings)

(defun vg-php-flycheck-use-phpcs()
  "Make Flycheck use PHPCS instead of LSP."
  (interactive)
  (when (string= (file-name-extension (buffer-file-name)) "php")
    (when vg-php-lsp-use-phpcs
      (flycheck-select-checker 'php-phpcs)
      ;; (message "Hook: lsp-after-open-hook called!")
      (message "Flycheck is now using PHPCS!"))))
(add-hook 'lsp-after-open-hook 'vg-php-flycheck-use-phpcs)

;;;;;;;;;;;;;;
;; Sidekick ;;
;;;;;;;;;;;;;;

;; See:
;; https://github.com/VernonGrant/sidekick.el

(use-package package-lint :ensure t)

;; Add custom plugin development load path.
(setq-default load-path (append load-path '("~/Devenv/projects/sidekick/")))
(require 'sidekick)

;; Add custom web mode file associations.
(sidekick-set-file-associations "web-mode" "*.{php,scss,css,html}")
(sidekick-set-file-associations "clojure-mode" "*.clj")

;; Add sidekick default bindings.
(global-set-key (kbd "C-c k") 'sidekick-at-point)
(global-set-key (kbd "C-c K") 'sidekick-focus-toggle)
(global-set-key (kbd "C-c C-k") 'sidekick-search-for-literal)

;;;;;;;;;;;;;;;;
;; Abbreviate ;;
;;;;;;;;;;;;;;;;

;; See:
;; https://github.com/VernonGrant/abbreviate.el

(setq-default load-path (append load-path '("~/Devenv/projects/abbreviate_el/")))
(require 'abbreviate)

;; Add this to abbreviate.el
(abbreviate-insert-abbreviations '(("function" . "func")))
(global-set-key (kbd "C-c a") 'abbreviate-word-at-point)

;;;;;;;;;;;;;;;
;; GDB Setup ;;
;;;;;;;;;;;;;;;

;; ;; GDB setup, close GDB by typing C-x 4 0 (kill-buffer-and-window).
;; (setq gdb-many-windows t)

;; ;; Start GDB debugging session.
;; (define-key global-map (kbd "C-c cc") 'gdb)

;; (defun vg-gdb-set-local-bindings()
;;   "Set key bindings specifically for gdb-mode.
;; Helps exit GDB and all its windows."
;;   (interactive)
;;       (local-set-key (kbd "C-c c c") 'kill-buffer-and-window))
;; (add-hook 'gdb-mode-hook 'vg-gdb-set-local-bindings)

;;;;;;;;;;;;;;;;;;;
;; C Programming ;;
;;;;;;;;;;;;;;;;;;;

(defcustom vg-c-clang-format-on-save
  nil "Auto format the C file before save." :type '(boolean))

(defun vg-c-clang-format-current-file()
  "Will check if a clang format is available.
Use that to format the current C file."
  (interactive)
  (let ((clang-format-cmd "clang-format")
        (cursor-line (line-number-at-pos))
		(cursor-column (current-column)))
    (shell-command-on-region
	 (point-min) (point-max) clang-format-cmd t (buffer-name))
    (goto-line cursor-line)
	(move-to-column cursor-column t)
    (recenter-top-bottom)))

(defun vg-c-before-save-actions()
  "Run a series of tools on the current C file, before save."
  (when (or (string= (file-name-extension (buffer-file-name)) "c")
            (string= (file-name-extension (buffer-file-name)) "h"))
    (when vg-c-clang-format-on-save
      (vg-c-clang-format-current-file))))
(add-hook 'before-save-hook 'vg-c-before-save-actions)

(defun vg-c-set-local-bindings()
  "Set bindings based on file extensions, when using web-mode."
  (interactive)
  (when (or (string= (file-name-extension (buffer-file-name)) "c")
            (string= (file-name-extension (buffer-file-name)) "h"))
    (local-set-key (kbd "C-c l f") 'vg-c-clang-format-current-file)))
(add-hook 'c-mode-hook 'vg-c-set-local-bindings)

;;;;;;;;;;;;;
;; Clojure ;;
;;;;;;;;;;;;;

(defun vg-clojure-set-local-bindings()
  "Set bindings based on file extensions, when using web-mode."
  (interactive)
  (when (or (string= (file-name-extension (buffer-file-name)) "clj")
            (string= (file-name-extension (buffer-file-name)) "edn"))
    ;; Work out the best kind of binding for local modes.
    (local-set-key (kbd "C-c l d") 'cider-doc)
    (local-set-key (kbd "C-c l f") 'cider-format-buffer)))

(add-hook 'clojure-mode-hook 'vg-clojure-set-local-bindings)

;;;;;;;;;;;;;;;
;; Mac Usage ;;
;;;;;;;;;;;;;;;


(if (eq system-type 'darwin)
    ;; Maximize Emacs window on start.
    (add-to-list 'default-frame-alist '(fullscreen . maximized))
  )

;;;;;;;;;;;;;;
;; Key Maps ;;
;;;;;;;;;;;;;;

;; Finding files inside a project without 3rd party tools and insane speed.
;; Use the command: locate
(define-key global-map (kbd "C-c f") 'vg-locate-project-file)
(define-key global-map (kbd "C-c F") 'locate)

(define-key global-map (kbd "C-c r") 'recentf-open-files)

;; Search code base.
(define-key global-map (kbd "C-c s s") 'rgrep)

;; Find other file.
(define-key global-map (kbd "C-c o") 'ff-find-other-file)

;; Use Ibuffer instead.
(define-key global-map (kbd "C-x C-b") 'ibuffer-other-window)

;; Quickly open Emacs configuration.
(define-key global-map (kbd "C-c 1")
  (lambda ()
    (interactive)
    (find-file-other-window "~/.emacs")))

;; duplicate a line.
(define-key global-map (kbd "C-c d") 'vg-duplicate-line)

;; Open agenda.
(define-key global-map (kbd "C-c 2") 'vg-org-agenda-list-other-window)

;; Compile, make.
(define-key global-map (kbd "C-c M") 'compile)
(define-key global-map (kbd "C-c m") 'recompile)

;; Browsing.
(define-key global-map (kbd "C-c b b")
  (lambda ()
    (interactive)
    (eww "https://google.com")))

;; Open Emacs configuration.
(define-key global-map (kbd "C-c 1")
  (lambda ()
    (interactive)
    (find-file "~/.emacs")))
(define-key global-map (kbd "C-c 4 1")
  (lambda ()
    (interactive)
    (find-file-other-window "~/.emacs")))

(define-key global-map (kbd "C-c e")
  (lambda ()
    (interactive)
    (vg-async-shell-command-no-window "Open .")))

(define-key global-map (kbd "C-c t")
  (lambda ()
    (interactive)
    (vg-async-shell-command-no-window "open -a Terminal .")))
