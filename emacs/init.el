;;; -*- lexical-binding: t -*-

;; Package manager
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Import PATH from shell
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize))

;; Basic settings

(setq desktop-save t)
(setq desktop-restore-frames t)
(setq inhibit-startup-screen t)
(setq select-enable-clipboard t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(desktop-save-mode 1)

;; Interface
(setq ring-bell-function 'ignore)
(setq visible-bell t)
(setq scroll-conservatively 101)
(setq scroll-margin 6)
(setq global-auto-revert-non-file-buffers t)
(setq dired-listing-switches "-lah --group-directories-first")
(pixel-scroll-precision-mode 1)
(global-auto-revert-mode 1)

(global-display-line-numbers-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq compile-command "")
(global-set-key (kbd "C-x m") 'compile)

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Vendored
(add-to-list 'custom-theme-load-path (expand-file-name "vendor/themes" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "vendor/modes" user-emacs-directory))

(require 'odin-mode)

;; Packages
(use-package clang-format
  :ensure t
  :hook (c-mode-common . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
        (c++-ts-mode    . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
  :config
  (setq clang-format-fallback-style "none"))

(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
