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

;; Interface and sound
(setq ring-bell-function 'ignore)
(setq visible-bell t)
(setq scroll-margin 7)
(setq scroll-conservatively 101)
(setq scroll-step 1)
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; Import PATH from shell
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize))

;; Le shit for normal copy-pasting
(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))

;; clang-format
(use-package clang-format
  :ensure t
  :hook (c-mode-common . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
        (c++-ts-mode    . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
  :config
  (setq clang-format-fallback-style "none"))

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-ts-mode))

;; Compilation
(setq compile-command "")
(global-set-key (kbd "C-x m") 'compile)

;; Clipboard
(setq select-enable-clipboard t)

;; Tabs
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode t) ;; i don't remember is it spaces or tabs mode, nevermind
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method nil)
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'innamespace 0)))

;; Visuals
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(electric-pair-mode t)
(setq whitespace-style '(face tabs spaces trailing space-mark tab-mark))
(global-whitespace-mode t)
(setq dired-listing-switches "-lah --group-directories-first")

;; Disable garbage files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Colorized compilation buffer
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; External stuff
(add-to-list 'load-path (expand-file-name "external" user-emacs-directory))
(require 'odin-mode)

;; custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Not working fix for whitespace colors (check 'base16' theme)
(with-eval-after-load 'whitespace
  (custom-set-faces
   '(trailing-whitespace ((t (:background "grey20" :foreground "gray30"))))
   '(whitespace-space ((t (:background nil :foreground "gray30"))))
   '(whitespace-tab ((t (:background nil :foreground "gray30"))))
   '(whitespace-indentation ((t (:background nil :foreground "gray30"))))
   '(whitespace-empty ((t (:background nil :foreground "gray30"))))))
