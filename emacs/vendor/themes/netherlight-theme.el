;;; netherlight-theme.el --- The netherlight color theme -*- lexical-binding: t; -*-

;; Author: Sergěj Višnjevecki <github.com/kSarkans>
;; Version: 0.1
;; Filename: netherlight-theme.el
;; Package-Requires: ((emacs "24"))
;; URL: https://github.com/kSarkans/dotfiles/tree/master/emacs/vendor/themes/netherlight-theme.el
;; License: GPL-3+

;;; Commentary:

;; Naysayer family theme. Based on 'naysayer-theme' by Nick Aversano.

;;; Code:

(unless (>= emacs-major-version 24)
  (error "The Netherlight theme requires Emacs 24 or later!"))

(deftheme netherlight "The Netherlight color theme")

;; Monokai colors
(defcustom netherlight-theme-yellow "#E6DB74" "Primary colors - yellow" :type 'string :group 'monokai)
(defcustom netherlight-theme-orange "#FD971F" "Primary colors - orange" :type 'string :group 'monokai)
(defcustom netherlight-theme-red "#F92672" "Primary colors - red" :type 'string :group 'monokai)
(defcustom netherlight-theme-magenta "#FD5FF0" "Primary colors - magenta" :type 'string :group 'monokai)
(defcustom netherlight-theme-blue "#66D9EF" "Primary colors - blue" :type 'string :group 'monokai)
(defcustom netherlight-theme-green "#A6E22E" "Primary colors - green" :type 'string :group 'monokai)
(defcustom netherlight-theme-cyan "#A1EFE4" "Primary colors - cyan" :type 'string :group 'monokai)
(defcustom netherlight-theme-violet "#AE81FF" "Primary colors - violet" :type 'string :group 'monokai)

(let ((background "#08171C")
      (gutters    "#08171C")
      (gutter-fg  "#08171C")
      (gutters-active "#08171C")
      (builtin      "#FFFFFF")
      (selection  "#0000FF")
      (text       "#EECB9F")
      (comments   "#559E55")
      (punctuation "#D6F7FF")
      (keywords "#FFFFFF")
      (variables "#EECB9F")
      (functions "#EECB9F")
      (methods    "#EECB9F")
      (types      "#FFD08E")
      (strings    "#32D48E")
      (constants "#85E0D6")
      (macros "#B4B4B4")
      (numbers "#85E0D6")
      (white     "#FFFFFF")
      (error "#FF0000")
      (warning "#ffaa00")
      (highlight-line "#13262C")
      (line-fg "#126367"))

  (custom-theme-set-faces
   'netherlight

   ;; Default colors
   ;; *****************************************************************************

   `(default                          ((t (:foreground ,text :background ,background, :weight normal))))
   `(region                           ((t (:foreground nil :background ,selection))))
   `(cursor                           ((t (:background ,text                        ))))
   `(fringe                           ((t (:background ,background   :foreground ,white))))
   `(linum                            ((t (:background ,background :foreground ,gutter-fg))))
   `(highlight ((t (:foreground nil :background ,selection))))

   ;; Font lock faces
   ;; *****************************************************************************

   `(font-lock-keyword-face           ((t (:foreground ,keywords))))
   `(font-lock-type-face              ((t (:foreground ,types))))
   `(font-lock-constant-face          ((t (:foreground ,constants))))
   `(font-lock-variable-name-face     ((t (:foreground ,variables))))
   `(font-lock-builtin-face           ((t (:foreground ,builtin))))
   `(font-lock-string-face            ((t (:foreground ,strings))))
   `(font-lock-comment-face           ((t (:foreground ,comments))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comments))))
   `(font-lock-doc-face               ((t (:foreground ,comments))))
   `(font-lock-function-name-face     ((t (:foreground ,functions))))
   `(font-lock-doc-string-face        ((t (:foreground ,strings))))
   `(font-lock-preprocessor-face      ((t (:foreground ,macros))))
   `(font-lock-warning-face           ((t (:foreground ,warning))))

   ;; Plugins
   ;; *****************************************************************************
   `(trailing-whitespace ((t (:foreground nil :background ,warning))))
   `(whitespace-trailing ((t (:background nil :foreground ,warning :inverse-video t))))

   `(linum ((t (:foreground ,line-fg :background ,background))))
   `(linum-relative-current-face ((t (:foreground ,white :background ,background))))
   `(line-number ((t (:inherit default :foreground ,line-fg :background ,background))))
   `(line-number-current-line ((t (:inherit default :foreground ,white :background ,background))))

   ;; compilation
   `(compilation-info ((t ,(list :foreground netherlight-theme-green
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground netherlight-theme-yellow
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground, error))))
   `(compilation-mode-line-fail ((t ,(list :foreground error
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground netherlight-theme-green
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;; hl-line-mode
   `(hl-line ((t (:background ,highlight-line))))
   `(hl-line-face ((t (:background ,highlight-line))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,netherlight-theme-violet))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,netherlight-theme-blue))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,netherlight-theme-green))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,netherlight-theme-yellow))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,netherlight-theme-orange))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,netherlight-theme-red))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,netherlight-theme-violet))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,netherlight-theme-blue))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,netherlight-theme-green))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,netherlight-theme-yellow))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,netherlight-theme-orange))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,netherlight-theme-red))))

   ;; which-func
   `(which-func ((t (:inverse-video unspecified
                                    :underline unspecified
                                    :foreground ,background
                                    :weight bold
                                    :box nil))))

   ;; mode-line and powerline
   `(mode-line-buffer-id ((t (:foreground ,background :distant-foreground ,text :text ,text :weight bold))))
   `(mode-line ((t (:inverse-video unspecified
                                   :underline unspecified
                                   :foreground ,background
                                   :background ,text
                                   :box nil))))
   `(powerline-active1 ((t (:background ,text :foreground ,background))))
   `(powerline-active2 ((t (:background ,text :foreground ,background))))

   `(mode-line-inactive ((t (:inverse-video unspecified
                                            :underline unspecified
                                            :foreground ,text
                                            :background ,background
                                            :box nil))))
   `(powerline-inactive1 ((t (:background ,background :foreground ,text))))
   `(powerline-inactive2 ((t (:background ,background :foreground ,text))))

    ;; better compatibility with default DOOM mode-line
   `(error ((t (:foreground nil :weight normal))))
   `(doom-modeline-project-dir ((t (:foreground nil :weight bold))))
   
   ;; js2-mode
   `(js2-function-call ((t (:inherit (font-lock-function-name-face)))))
   `(js2-function-param ((t (:foreground ,text))))
   `(js2-jsdoc-tag ((t (:foreground ,keywords))))
   `(js2-jsdoc-type ((t (:foreground ,constants))))
   `(js2-jsdoc-value((t (:foreground ,text))))
   `(js2-object-property ((t (:foreground ,text))))
   `(js2-external-variable ((t (:foreground ,constants))))
   `(js2-error ((t (:foreground ,error))))
   `(js2-warning ((t (:foreground ,warning))))

   ;; highlight numbers
   `(highlight-numbers-number ((t (:foreground ,numbers))))

   ;; tab-bar-mode
   `(tab-bar ((t (:inherit modeline))))
   `(tab-bar-tab ((t (:foreground ,background :background ,text))))
   `(tab-bar-tab-inactive ((t (:foreground ,text :background ,background))))
  )

  (custom-theme-set-variables
    'netherlight
    '(linum-format " %5i ")
  )
)

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;; *****************************************************************************

(provide-theme 'netherlight)

;; Local Variables:
;; no-byte-compile: t
;; End:

(provide 'netherlight-theme)

;;; netherlight-theme.el ends here
