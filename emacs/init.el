;;; -*- lexical-binding: t -*-

;; Инициализация пакетного менеджера (чтобы use-package работал железно)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Если use-package еще не установлен, Emacs сам его скачает
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Интерфейс и звук
(setq ring-bell-function 'ignore) ;; Полностью глушим звук (visible-bell ниже можно убрать, если бесит мигание)
(setq visible-bell t)
(setq scroll-margin 7)
(setq scroll-conservatively 101)
(setq scroll-step 1)

;; Импорт PATH из Zsh (теперь отработает как надо)
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize))
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard t))
(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))
(use-package clang-format
  :ensure t
  ;; :bind (:map c-mode-map       ("C-c C-f" . clang-format-buffer)
  ;;        :map c++-mode-map     ("C-c C-f" . clang-format-buffer)
  ;;        :map c++-ts-mode-map  ("C-c C-f" . clang-format-buffer))
  :hook (c-mode-common . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
        (c++-ts-mode    . (lambda () (local-set-key (kbd "C-c C-f") #'clang-format-buffer)))
  :config
  (setq clang-format-fallback-style "none"))

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-ts-mode))

;; Настройка компиляции
(setq compile-command "")
(global-set-key (kbd "C-x m") 'compile)

;; Буфер обмена и табы
(setq select-enable-clipboard t)
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq backward-delete-char-untabify-method nil)
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'innamespace 0)))

;; Визуал
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(electric-pair-mode t)
(setq whitespace-style '(face tabs spaces trailing space-mark tab-mark))
(global-whitespace-mode t)
(setq dired-listing-switches "-lah --group-directories-first")

;; Шрифт и бэкапы
(set-face-attribute 'default nil :height 130)
(setq make-backup-files nil)
(setq auto-save-default nil)

(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; Сторонние моды
(add-to-list 'load-path (expand-file-name "external" user-emacs-directory))
(require 'odin-mode)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
