;;; -*- lexical-binding: t -*-

;; Package manager
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))
      )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )
(eval-when-compile (require 'use-package))

;; Import PATH from shell
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize)
  )

;; Basic settings

; (setq desktop-save t)
; (setq desktop-restore-frames t)
(setq inhibit-startup-screen t)
(setq select-enable-clipboard t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
; (desktop-save-mode 1)

;; Interface
(setq frame-resize-pixelwise t)
(setq ring-bell-function 'ignore)
(setq visible-bell t)
(setq scroll-conservatively 101)
(setq scroll-margin 6)
(setq global-auto-revert-non-file-buffers t)
(setq dired-listing-switches "-lah --group-directories-first")
(setq use-short-answers t)
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq display-line-numbers 'relative)
(setq c-default-style "java")
(setq display-line-numbers-type 'relative)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
; (pixel-scroll-precision-mode 1)
(global-auto-revert-mode 1)

;; Fix line numbers font size on some themes.
(add-hook 'enable-theme-functions
          (lambda (_theme)
            ;; Right line number font size for all themes
            (set-face-attribute 'line-number nil :inherit 'default :height 1.0)
            (set-face-attribute 'line-number-current-line nil :inherit 'line-number :height 1.0)

            ;; Less annoying pait symbols highlighting
            (set-face-attribute 'show-paren-match nil
                                :background 'unspecified
                                :foreground 'unspecified
                                :weight 'bold
                                )))

(global-display-line-numbers-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(global-superword-mode t)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq compile-command "")
(global-set-key (kbd "C-x m") 'compile)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Vendored
(add-to-list 'custom-theme-load-path (expand-file-name "vendor/themes" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "vendor/modes" user-emacs-directory))

(require 'odin-mode)

;; Packages

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c m a" . mc/mark-all-like-this)
         ("C-c m l" . mc/edit-lines))
  :config
  (dolist (cmd '(c-electric-colon
                 c-electric-semi&comma
                 c-electric-brace
                 c-electric-paren
                 c-electric-lt-gt
                 c-electric-slash))
    (add-to-list 'mc/cmds-to-run-for-all cmd)))

(use-package eglot
  :config
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  :bind (:map eglot-mode-map
              ("C-c C-l f" . eglot-format)
              ("C-c C-l F" . eglot-format-buffer)
              ("C-c C-l r" . eglot-rename)
              ("C-c C-l i" . eglot-inlay-hints-mode)
              ("C-c C-l d" . eglot-find-declaration)))

(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point)
     )
    )
  )

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t))

(use-package which-key
  :config
  (which-key-mode 1))

;; Post-config

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
