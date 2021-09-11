(when window-system
  (blink-cursor-mode 0)                           ; Disable the cursor blinking
  (scroll-bar-mode 0)                             ; Disable the scroll bar
  (tool-bar-mode 0)                               ; Disable the tool bar
  (tooltip-mode 0))                               ; Disable the tooltips

(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 auto-window-vscroll nil                          ; Lighten vertical scroll
 confirm-kill-emacs 'yes-or-no-p                  ; Confirm before exiting Emacs
 cursor-in-non-selected-windows nil               ; Hide the cursor in inactive windows
 delete-by-moving-to-trash t                      ; Delete files to trash
 display-time-default-load-average nil            ; Don't display load average
 display-time-format "%H:%M"                      ; Format the time string
 fill-column 90                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Stop using tabs to indent
 inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 mouse-yank-at-point t                            ; Yank at point rather than pointer
 ns-use-srgb-colorspace nil                       ; Don't use sRGB colors
 recenter-positions '(5 top bottom)               ; Set re-centering positions
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 scroll-margin 10                                 ; Add a margin when scrolling vertically
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil                    ; End a sentence after a dot and a space
 show-trailing-whitespace nil                     ; Display trailing whitespaces
 split-height-threshold nil                       ; Disable vertical window splitting
 split-width-threshold nil                        ; Disable horizontal window splitting
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; Resize windows proportionally
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width
(cd "~/")                                         ; Move to the user directory
(delete-selection-mode 1)                         ; Replace region when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(fringe-mode 0)                                   ; Disable fringes
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-subword-mode 1)                           ; Iterate through CamelCase words
(menu-bar-mode 0)                                 ; Disable the menu bar
(mouse-avoidance-mode 'banish)                    ; Avoid collision of mouse with point
(put 'downcase-region 'disabled nil)              ; Enable downcase-region
(put 'upcase-region 'disabled nil)                ; Enable upcase-region
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(setq visible-bell 1)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq shift-select-mode nil)
(set-cursor-color "#00bfff")

(if (eq window-system 'ns)
    (toggle-frame-maximized)
    (toggle-frame-maximized))

(add-hook 'focus-out-hook #'garbage-collect)

(setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(defvar me/erc-nick               nil        "The ERC nick to use.")
(defvar me/erc-password           nil        "The ERC password to use.")
(defvar me/erc-port               nil        "The ERC port to use.")
(defvar me/erc-server             nil        "The ERC server to use.")
(defvar me/font-family            "Source Code Pro"  "The font to use.")
(defvar me/font-size-default      130        "The font size to use for default text.")
(defvar me/font-size-header-line  130        "The font size to use for the header-line.")
(defvar me/font-size-mode-line    130        "The font size to use for the mode-line.")
(defvar me/font-size-small        100        "The font size to use for smaller text.")
(defvar me/font-size-title        130        "The font size to use for titles.")

(let ((secret.el (expand-file-name ".secret.el" user-emacs-directory)))
  (when (file-exists-p secret.el)
    (load secret.el)))

(use-package doom-themes
 :demand t
 :custom
 (doom-themes-enable-bold nil)
 :config
 (load-theme 'doom-dracula t)
 (with-eval-after-load 'flycheck
   (set-face-attribute 'flycheck-error nil :underline `(:color ,(doom-color 'error) :style line))
   (set-face-attribute 'flycheck-info nil :underline `(:color ,(doom-color 'highlight) :style line))
   (set-face-attribute 'flycheck-warning nil :underline `(:color ,(doom-color 'warning) :style line)))
 (with-eval-after-load 'helm-buffers
   (set-face-attribute 'helm-buffer-directory nil
                       :background 'unspecified
                       :foreground 'unspecified
                       :inherit 'dired-directory)
   (set-face-attribute 'helm-buffer-file nil :inherit 'unspecified)
   (set-face-attribute 'helm-buffer-modified nil :foreground (doom-color 'orange) :inherit 'unspecified)
   (set-face-attribute 'helm-buffer-not-saved nil :foreground (doom-color 'red) :inherit 'unspecified)
   (set-face-attribute 'helm-non-file-buffer nil :inherit 'font-lock-comment-face))
 (with-eval-after-load 'helm-command
   (set-face-attribute 'helm-M-x-key nil :foreground (doom-color 'yellow) :underline 'unspecified))
 (with-eval-after-load 'helm-files
   (set-face-attribute 'helm-ff-directory nil
                       :background 'unspecified
                       :foreground 'unspecified
                       :inherit 'dired-directory))
 (with-eval-after-load 'isearch
   (set-face-attribute 'isearch nil :background (doom-color 'blue) :foreground (doom-color 'dark-blue))
   (set-face-attribute 'lazy-highlight nil :foreground (doom-color 'blue)))
 (with-eval-after-load 'faces
   (set-face-attribute 'default nil :font me/font-family :height me/font-size-default)
   (set-face-attribute 'header-line nil :box `(:color ,(doom-color 'modeline-bg) :line-width 7))
   (set-face-attribute 'help-argument-name nil :foreground (doom-color 'yellow))
   (set-face-attribute 'mode-line nil :height me/font-size-mode-line)
   (set-face-attribute 'variable-pitch nil :family 'unspecified))
 (with-eval-after-load 'font-lock
   (set-face-attribute 'font-lock-doc-face nil :italic t))
 (with-eval-after-load 'helm
   (set-face-attribute 'helm-source-header nil :background 'unspecified))
 (with-eval-after-load 'markdown
   (set-face-attribute 'markdown-table-face nil :height me/font-size-small))
 (with-eval-after-load 'outline
   (set-face-attribute 'outline-1 nil :background 'unspecified))
 (with-eval-after-load 'magit-diff
   (set-face-attribute 'magit-diff-added nil :background 'unspecified)
   (set-face-attribute 'magit-diff-hunk-region nil :inherit 'region)
   (set-face-attribute 'magit-diff-removed nil :background 'unspecified)))

;; (use-package spacemacs-theme
  ;;   :ensure t
  ;;   :init
  ;;   (load-theme 'spacemacs-dark t)
  ;;   (setq spacemacs-theme-org-agenda-height nil)
  ;;   (setq spacemacs-theme-org-height nil))
  (use-package spaceline
    :demand t
    :init
    (setq powerline-default-separator 'arrow-fade)
    :config
    (require 'spaceline-config)
    (spaceline-emacs-theme)
    (spaceline-toggle-major-mode-on)
    (spaceline-toggle-minor-modes-off)
    (fancy-battery-mode 1)
    (setq fancy-battery-show-percentage t)
    (setq spaceline-highlight-face-func 'spaceline-highlight-face-modified)
    ;(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
)
(custom-set-faces
 '(spaceline-modified ((t (:background "OrangeRed" :foreground "#3E3D31"
                                       :inherit (quote mode-line))))))

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(dashboard-setup-startup-hook)
(setq show-week-agenda-p t)

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(setq dashboard-items '((recents  . 8)
                        (bookmarks . 8)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(use-package hl-line
  :ensure nil
  :preface (defun me/hl-line-mode-off () (setq-local global-hl-line-mode nil))
  :hook (after-init . global-hl-line-mode))

(use-package paradox
  :custom
  (paradox-column-width-package 27)
  (paradox-column-width-version 13)
  (paradox-execute-asynchronously t)
  (paradox-github-token t)
  (paradox-hide-wiki-packages t)
  :config
  (remove-hook 'paradox-after-execute-functions #'paradox--report-buffer-print))

(use-package prog-mode
  :ensure nil
  :preface
  (defun me/prettify-symbols-compose-predicate (&rest arguments)
    (when (not (eq system-type 'windows-nt))
      (apply #'prettify-symbols-default-compose-p arguments)))
  :custom
  (prettify-symbols-compose-predicate #'me/prettify-symbols-compose-predicate)
  (prettify-symbols-unprettify-at-point 'right-edge))

(use-package rainbow-mode
  :hook prog-mode
  :custom (rainbow-x-colors-major-mode-list '()))

(use-package simple
  :ensure nil
  :hook
  ((prog-mode . turn-on-auto-fill)
   (text-mode . turn-on-auto-fill)))

(use-package fancy-battery)
(add-hook 'after-init-hook #'fancy-battery-mode)

(use-package all-the-icons)

(defun latex-word-count ()
  (interactive)
  (shell-command (concat "/home/gogo/Software/texcount.pl "
                          "-v0 "
                         (buffer-file-name))))

(use-package auctex
  :defer t
  :ensure t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (font-latex-fontify-script nil)
  :config
  (add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode)))

(use-package org
  :ensure nil

  :preface
  (defun me/org-src-buffer-name (org-buffer-name language)
    "Construct the buffer name for a source editing buffer. See `org-src--construct-edit-buffer-name'."
    (format "*%s*" org-buffer-name))
  (defun me/org-set-ongoing-hydra-body ()
    (setq me/ongoing-hydra-body #'hydra-org/body))
  :bind
  (:map org-mode-map
        ([remap backward-paragraph] . me/backward-paragraph-dwim)
        ([remap forward-paragraph] . me/forward-paragraph-dwim)
        ("<C-return>" . nil)
        ("<C-S-down>" . nil)
        ("<C-S-up>" . nil))

  :hook
  ((org-mode . me/org-set-ongoing-hydra-body)
   (org-mode . org-sticky-header-mode)
   (org-mode . toc-org-enable))
  :custom
  (org-descriptive-links nil)
  (org-edit-src-content-indentation 0)
  (org-edit-src-persistent-message nil)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-src-window-setup 'current-window)
  (org-startup-folded 'content)
  (org-startup-truncated nil)
  (org-support-shift-select 0)

  :config
  (advice-add 'org-src--construct-edit-buffer-name :override #'me/org-src-buffer-name)
  ;; Prettify Org headings
  (let* ((variable-tuple
        (cond ((x-list-fonts "Source Sans Pro")         '(:font "Source Sans Pro"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Source Sans Pro")   '(:font "Source Sans Pro"))
              ;((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#8470ff"))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#228b22"))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#5f9ea0"))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#6a5acd"))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 1.2 :foreground "#6a5acd"))))))
  ;; Agenda customization
  (setq org-agenda-files (list "~/Dropbox/orgfiles/work.org" "~/Dropbox/orgfiles/Life.org" "~/Dropbox/orgfiles/newgtd.org"))
  (setq org-capture-templates
        '(("a" "Appointment" entry (file+headline  "~/Dropbox/orgfiles/newgtd.org" "Appointments:" ) "*** %?\n:SCHEDULED: %^T\n:PROPERTIES:\n:END:\n")
          ("f" "Follow up Later" entry (file+headline  "~/Dropbox/orgfiles/newgtd.org" "Follow up Later:" ) "** %?\n")
          ("F" "Follow up Later (work)" entry (file+headline  "~/Dropbox/orgfiles/work.org" "Follow up Later:" ) "** %?\n")
          ("l" "Important Link (work)" entry (file+headline "~/Dropbox/orgfiles/work.org" "Important Links") "* %? %^L %^g \n%T" :prepend t)
          ("L" "Read/Watch later" entry (file+headline "~/Dropbox/orgfiles/Life.org" "Links") "** %? %^L %^g \n%T" :prepend t)
          ("s" "Shopping list" checkitem (file+headline "~/Dropbox/orgfiles/newgtd.org" "Shopping List:") "- [ ] %?\n" :prepend t)
          ("t" "Work TODO" entry (file+headline "~/Dropbox/orgfiles/newgtd.org" "Work") "*** TODO %?%^g\n:CREATED: %u\n:SCHEDULED: %^T\n:DEADLINE: %^T" :prepend t)
          ("T" "Personal TODO" entry (file+headline "~/Dropbox/orgfiles/newgtd.org" "Life") "*** TODO %?%^g\n:CREATED: %u\n:SCHEDULED: %^T\n:DEADLINE: %^T" :prepend t)
          ("n" "Note (work)" entry (file+headline "~/Dropbox/orgfiles/work.org" "Note space:") "** %?\n%u" :prepend t)
          ("N" "Note (personal)" entry (file+headline "~/Dropbox/orgfiles/Life.org" "Note space:") "** %?\n%u" :prepend t)
          ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))

  (defadvice org-agenda (around split-vertically activate)
    (let ((split-width-threshold 80))  ; or whatever width makes sense for you
      ad-do-it))
  (defadvice org-capture (around split-vertically activate)
    (let ((split-width-threshold 80))  ; or whatever width makes sense for you
      ad-do-it))

  ;; Org refile
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)

  ;; Org todo
  (setq org-todo-keywords'((sequence "TODO(t)" "ONGOING(o)" "ALMOST(a)" "VERIFY(v)" "|" "DONE(d)" "DELEGATED(D)" "CANCELED(c)")))

  (setq org-todo-keyword-faces
        '(("TODO" . "#ff6347")
          ("ONGOING" . "#ffd700")
          ("ALMOST" . "#228b22")
          ("VERIFY" . "#bc8f87")
          ("CANCELED" . (:foreground "white" :background "#ff6347" :weight bold))
          ("DELEGATED" . (:foreground "white" :background "#bc8f87" :weight bold))
          ("DONE" . (:foreground "white" :background "#228b22" :weight bold))))

  ;; Org-latex output
  (setq org-latex-pdf-process
        '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
  (require 'ox-beamer)
  (setq org-highlight-latex-and-related '(latex script entities))

  ;; Org babel language load
  (org-babel-do-load-languages
   'org-babel-load-languages '((python . t)))
  (setq org-babel-python-command "/home/gogo/Software/anaconda3/bin/python")

  ;; Fill Paragraph in org-mode latex block
  (defun org-fill-paragraph--latex-environment (&rest args)
    "Use default fill-paragraph in latex environments."
    (not (eql (org-element-type (org-element-context)) 'latex-environment)))

  (advice-add 'org-fill-paragraph :before-while #'org-fill-paragraph--latex-environment))
(global-set-key (kbd "\C-c c") 'org-capture)
(global-set-key (kbd "\C-c a") 'org-agenda)

(use-package org-sticky-header
  :custom
  (org-sticky-header-full-path 'full)
  (org-sticky-header-outline-path-separator " / ")
  :config
  (setq-default
   org-sticky-header-header-line-format
   '(:eval (setq org-sticky-header-stickyline (concat " " (org-sticky-header--fetch-stickyline))))))

(use-package toc-org :after org)

;(add-hook 'org-mode-hook 'org-indent-mode)

;(use-package org-bullets
;  :config
;  (add-hook 'org-mode-hook (lambda () (org-bullets-mode t))))
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "□" "◉" "○" "□" "✸")))
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

  ;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; (let* ((variable-tuple
;;         (cond ((x-list-fonts "Source Sans Pro")         '(:font "Source Sans Pro"))
;;               ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;               ((x-list-fonts "Source Sans Pro")   '(:font "Source Sans Pro"))
;;               ;((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;        (base-font-color     (face-foreground 'default nil 'default))
;;        (headline           `(:inherit default :weight bold :foreground ,base-font-color)))
;; 
;;   (custom-theme-set-faces
;;    'user
;;    `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#8470ff"))))
;;    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#228b22"))))
;;    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#5f9ea0"))))
;;    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.0 :foreground "#6a5acd"))))
;;    `(org-document-title ((t (,@headline ,@variable-tuple :height 1.2 :foreground "#6a5acd"))))))

(use-package org-ref
  ;; :init
  ; code to run before loading-org-ref
  :config
  (setq
   org-ref-completion-library 'org-ref-helm-bibtex
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   ;org-ref-bibliography-notes "~/Dropbox/orgfiles/bibnotes.org"
   org-ref-default-bibliography (list "/home/gogo/Dropbox/Bibliography/references.bib")
   org-ref-pdf-directory '("/home/gogo/Dropbox/Research_papers")
   org-ref-notes-directory "/home/gogo/wiki/refs/"
   org-ref-notes-function 'orb-edit-notes)

   (defun my/org-ref-open-pdf-at-point ()
    "Open the pdf for bibtex key under point if it exists."
    (interactive)
    (let* ((results (org-ref-get-bibtex-key-and-file))
           (key (car results))
           (pdf-file (concat org-ref-pdf-directory
                             (org-ref-get-pdf-filename
                              (org-ref-get-mendeley-filename key)))))
      (if (file-exists-p pdf-file)
          (find-file pdf-file)
        (message "no pdf found for %s" pdf-file))))

                                        ; default keybindings
  :bind
  (:map org-mode-map
        ("\C-c(" . org-ref-helm-insert-ref-link)
        ("\C-c)" . org-ref-helm-insert-cite-link)))

;; (global-set-key (kbd "\C-c c") 'org-capture)
;; (global-set-key (kbd "\C-c a") 'org-agenda)
;; (setq org-agenda-files (list "~/Dropbox/orgfiles/work.org" "~/Dropbox/orgfiles/Life.org" "~/Dropbox/orgfiles/newgtd.org"))
;; (setq org-capture-templates
;;       '(("a" "Appointment" entry (file+headline  "~/Dropbox/orgfiles/newgtd.org" "Appointments:" ) "*** %?\n:SCHEDULED: %^T\n:PROPERTIES:\n:END:\n")
;;       ("f" "Follow up Later" entry (file+headline  "~/Dropbox/orgfiles/newgtd.org" "Follow up Later:" ) "** %?\n")
;;       ("F" "Follow up Later (work)" entry (file+headline  "~/Dropbox/orgfiles/work.org" "Follow up Later:" ) "** %?\n")
;;       ("l" "Important Link (work)" entry (file+headline "~/Dropbox/orgfiles/work.org" "Important Links") "* %? %^L %^g \n%T" :prepend t)
;;       ("L" "Read/Watch later" entry (file+headline "~/Dropbox/orgfiles/Life.org" "Links") "** %? %^L %^g \n%T" :prepend t)
;;       ("s" "Shopping list" checkitem (file+headline "~/Dropbox/orgfiles/newgtd.org" "Shopping List:") "- [ ] %?\n" :prepend t)
;;       ("t" "Work TODO" entry (file+headline "~/Dropbox/orgfiles/newgtd.org" "Work") "*** TODO %?%^g\n:CREATED: %u\n:SCHEDULED: %^T\n:DEADLINE: %^T" :prepend t)
;;       ("T" "Personal TODO" entry (file+headline "~/Dropbox/orgfiles/newgtd.org" "Life") "*** TODO %?%^g\n:CREATED: %u\n:SCHEDULED: %^T\n:DEADLINE: %^T" :prepend t)
;;       ("n" "Note (work)" entry (file+headline "~/Dropbox/orgfiles/work.org" "Note space:") "** %?\n%u" :prepend t)
;;       ("N" "Note (personal)" entry (file+headline "~/Dropbox/orgfiles/Life.org" "Note space:") "** %?\n%u" :prepend t)
;;       ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))
;; 
;; (defadvice org-agenda (around split-vertically activate)
;;   (let ((split-width-threshold 80))  ; or whatever width makes sense for you
;;     ad-do-it))
;; (defadvice org-capture (around split-vertically activate)
;;   (let ((split-width-threshold 80))  ; or whatever width makes sense for you
;;     ad-do-it))

;; (global-set-key (kbd "\C-c \C-w") 'org-refile)
;; ;(global-set-key (kbd "S-c") "C")
;; (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
;; (setq org-refile-use-outline-path 'file)
;; (setq org-outline-path-complete-in-steps nil)
;; (setq org-refile-allow-creating-parent-nodes 'confirm)

;; (setq org-todo-keywords'((sequence "TODO(t)" "ONGOING(o)" "ALMOST(a)" "ORDERED(O)"  "FEEDBACK(f)" "VERIFY(v)" "|" "DONE(d)" "DELEGATED" "RECIEVED(r)" "CANCELED(c)")))
;; 
;;   (setq org-todo-keyword-faces
;;         '(("TODO" . org-warning) ("ONGOING" . "orange")
;;           ("CANCELED" . "red") ("DONE" . "#00ff7f") ("RECIEVED" . "green") ("ALMOST". "blue")))

;; (setq org-latex-pdf-process
;;         '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
;; (require 'ox-beamer)
;; (setq org-highlight-latex-and-related '(latex script entities))

(use-package org-autolist
  :hook (org-mode . org-autolist-mode))
;(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

(use-package pdf-tools
:ensure t
:config
(pdf-tools-install))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages '((python . t)))
;; (setq org-babel-python-command "/home/gogo/anaconda3/bin/python")

;; (defun org-fill-paragraph--latex-environment (&rest args)
;;   "Use default fill-paragraph in latex environments."
;;   (not (eql (org-element-type (org-element-context)) 'latex-environment)))

;; (advice-add 'org-fill-paragraph :before-while #'org-fill-paragraph--latex-environment)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/wiki")
  (setq org-roam-complete-link-at-point t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))

  :config
  (org-roam-setup)
  (add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer))))
    
  (use-package org-roam-bibtex
    :after org-roam
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :config
    (require 'org-ref)
    :bind
    (:map org-roam-bibtex-mode-map
          (("C-c m f" . orb-find-non-ref-file))
          :map org-mode-map
          (("C-c m t" . orb-insert-non-ref)
           ("C-c m a" . orb-note-actions)))
    :custom
    (orb-autokey-format "%a%y")
    (setq orb-note-actions-interface 'helm))

(setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file")
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf"))

(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)
        
        ("r" "bibliography reference" plain
         (file "/home/gogo/.emacs.d/template/orb-org-noter-integration-template")
         :if-new
         (file+head "refs/${citekey}.org" "#+title: ${title}\n"))))


;; (use-package org-roam
;;   ;; :init
;;   :hook (after-init . org-roam-mode)
;;   :config 
;;   (setq
;;    org-roam-directory "~/wiki"
;;    org-roam-tag-sources '(prop all-directories)
;;    org-roam-capture-templates
;;         '(("d" "default" plain (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "%<%Y-%m-%d-%H%M%S>-${slug}"
;;            :head "#+TITLE: ${title} "
;;            :unnarrowed t)
;;           ("r" "reference" plain (function org-roam--capture-get-point)
;;            "User input: %^{PROMPT}"
;;            :file-name "references/%<%Y-%m-%d-%H%M%S>-${slug}"
;;            :head "#+TITLE: ${title}"
;;            :unnarrowed t))))

;; (defvar orb-title-format "${author-or-editor-abbrev} (${date}).  ${title}."
;;   "Format of the title to use for `orb-templates'.")

;; (use-package org-roam-bibtex
;;  :after org-roam
;;  :hook (org-roam-mode . org-roam-bibtex-mode)
;;  :config
;;  (require 'org-ref)
;;  :bind (:map org-roam-bibtex-mode-map
;;         (("C-c m f" . orb-find-non-ref-file))
;;         :map org-mode-map
;;         (("C-c m t" . orb-insert-non-ref)
;;          ("C-c m a" . orb-note-actions)))
;;  :init
;;  :custom
;;  (orb-autokey-format "%a%y")
;;  (orb-templates
;;   `(("r" "ref" plain
;;      (function org-roam-capture--get-point)
;;      ""
;;      :file-name "refs/${citekey}"
;;      :head ,(s-join "\n"
;;                     (list
;;                      (concat "#+title: "
;;                              orb-title-format)
;;                      "#+roam_key: ${ref}"
;;                      "#+created: %U"
;;                      "#+last_modified: %U\n\n"))
;;      :unnarrowed t)
;;     ("p" "ref + physical" plain
;;      (function org-roam-capture--get-point)
;;      ""
;;      :file-name "refs/${citekey}"
;;      :head ,(s-join "\n"
;;                     (list
;;                      (concat "#+title: "
;;                              orb-title-format)
;;                      "#+roam_key: ${ref}"
;;                      ""
;;                      "* Notes :physical:")))
;;     ("n" "ref + noter" plain
;;      (function org-roam-capture--get-point)
;;      ""
;;      :file-name "refs/${citekey}"
;;      :head ,(s-join "\n"
;;                     (list
;;                      (concat "#+title: "
;;                              orb-title-format)
;;                      "#+roam_key: ${ref}"
;;                      ""
;;                      "* Notes :noter:"
;;                      ":PROPERTIES:"
;;                      ":NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")"
;;                      ":NOTER_PAGE:"
;;                      ":END:"))))))

;; ;(use-package org-roam-bibtex
;; ;  :after org-roam
;; ;  :hook (org-roam-mode . org-roam-bibtex-mode))
;; ;(use-package org-noter)

(use-package org-noter
  :bind (:map org-mode-map
         (("C-c N" . zp/org-noter-dwim))
         :map org-noter-doc-mode-map
         (("M-p" . zp/org-noter-insert-precise-note-dwim)))
; M-i replaces tab-to-tab-stop
  :config
  (setq org-noter-hide-other t
        org-noter-auto-save-last-location t
        org-noter-doc-split-fraction '(0.57 0.43))

  (defun zp/org-noter-visual-line-mode ()
    "Enable visual-line-mode in ‘org-noter’ notes.
Workaround to counter race conditions with the margins."
    (let ((parent (current-buffer))
          (refresh (lambda (parent)
                     (with-current-buffer parent
                       (visual-line-mode 'toggle)
                       (visual-line-mode 'toggle)))))
      (run-at-time "1 sec" nil refresh parent)
      (run-at-time "5 sec" nil refresh parent)))

  (add-hook 'org-noter-notes-mode-hook #'zp/org-noter-visual-line-mode)

  ;; Fix for hiding truncation
  (defun org-noter--set-notes-scroll (_window &rest _ignored)
    nil)

  ;; Fix for visual-line-mode with PDF files
  (defun org-noter--note-after-tipping-point (_point _note-property _view)
    nil)

  (defun zp/org-noter-indirect (arg)
    "Ensure that org-noter starts in an indirect buffer.
Without this wrapper, org-noter creates a direct buffer
restricted to the notes, but this causes problems with the refile
system.  Namely, the notes buffer gets identified as an
agenda-files buffer.
This wrapper addresses it by having org-noter act on an indirect
buffer, thereby propagating the indirectness."
    (interactive "P")
    (if (org-entry-get nil org-noter-property-doc-file)
        (with-selected-window (org-tree-to-indirect-buffer nil t)
        ;; (with-selected-window (zp/org-tree-to-indirect-buffer-folded nil t)
          (org-noter arg)
          (kill-buffer))
      (org-noter arg)))

  (defun zp/org-noter-dwim (arg)
    "Run org-noter on the current tree, even if we’re in the agenda."
    (interactive "P")
    (let ((in-agenda (derived-mode-p 'org-agenda-mode))
          (marker))
      (cond (in-agenda
             (setq marker (get-text-property (point) 'org-marker))
             (with-current-buffer (marker-buffer marker)
               (goto-char marker)
               (unless (org-entry-get nil org-noter-property-doc-file)
                 (user-error "No org-noter info on this tree"))
               (zp/org-noter-indirect arg)))
            (t
             (zp/org-noter-indirect arg)
             (setq marker (point-marker))))
      (org-with-point-at marker
        (let ((tags (org-get-tags)))
          (when (and (org-entry-get nil org-noter-property-doc-file)
                     (not (member "noter" tags)))
            (org-set-tags (push "noter" tags)))))
      (unless in-agenda
        (set-marker marker nil))))

  (defun zp/org-noter-insert-precise-note-dwim (force-mouse)
    "Insert note associated with a specific location.
If in nov-mode, use point rather than the mouse to target the
position."
    (interactive "P")
    (if (and (derived-mode-p 'nov-mode)
             (not force-mouse))
        (let ((pos (if (region-active-p)
                       (min (region-beginning) (point))
                     (point))))
          (org-noter-insert-note pos))
      (org-noter-insert-precise-note)))

  (define-key org-noter-doc-mode-map (kbd "j") 'pdf-view-next-line-or-next-page)
  (define-key org-noter-doc-mode-map (kbd "k") 'pdf-view-previous-line-or-previous-page))

(use-package projectile
  :hook
  (after-init . projectile-global-mode)
  :init
  (setq-default
   projectile-cache-file (expand-file-name ".projectile-cache" user-emacs-directory)
   projectile-known-projects-file (expand-file-name ".projectile-bookmarks" user-emacs-directory))
  :custom
  (projectile-completion-system 'helm)
  (projectile-enable-caching t))

(use-package yaml-mode :mode "\\.yml\\'")

(use-package python
  :ensure nil
  :hook (python-mode . turn-on-prettify-symbols-mode)
  :config
  (when (executable-find "ipython")
    (setq-default
     python-shell-interpreter "ipython"
     python-shell-interpreter-args "--colors=Linux --profile=default --simple-prompt"
     python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
     python-shell-prompt-regexp "In \\[[0-9]+\\]: "
     python-shell-completion-setup-code
     "from IPython.core.completerlib import module_completion"
     python-shell-completion-module-string-code
     "';'.join(module_completion('''%s'''))\n"
     python-shell-completion-string-code
     "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")))

(use-package anaconda-mode
  :hook ((python-mode . anaconda-mode)
         (python-mode . anaconda-eldoc-mode)))
;(add-hook 'python-mode-hook 'anaconda-mode)
;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/Software/anaconda3"))
  (setq conda-env-home-directory (expand-file-name "~/Software/anaconda3")))

(use-package company-anaconda
  :after company
  :config
  (add-to-list 'company-backends 'company-anaconda))
;(eval-after-load "company"
; '(add-to-list 'company-backends 'company-anaconda))

;(use-package pyvenv)
;(setenv "WORKON_HOME" (concat (getenv "CONDA_PREFIX") "/envs"))
;(pyvenv-mode 1)

(use-package em-hist
  :ensure nil
  :custom (eshell-hist-ignoredups t))

(use-package esh-mode
  :ensure nil
  :preface
  (defun me/eshell-bol-shifted ()
    "See `eshell-bol'. Support shift."
    (interactive "^")
    (eshell-bol))
  :bind
  (:map eshell-mode-map
        ([remap eshell-bol] . me/eshell-bol-shifted))
  :hook
  ((eshell-mode . me/hl-line-mode-off)
   (eshell-mode . (lambda () (setq-local scroll-margin 0))))
  :custom
  (eshell-scroll-to-bottom-on-input t))

(setq eshell-prompt-regexp "^[^#$\n]*[#$] "
      eshell-prompt-function
      (lambda nil
        (concat
         "[" (user-login-name) "@" (system-name) " "
         (if (string= (eshell/pwd) (getenv "HOME"))
             "~" (eshell/basename (eshell/pwd)))
         "]"
         (if (= (user-uid) 0) "# " "$ "))))

(use-package term
  :ensure nil
  :hook
  ((term-mode . me/hl-line-mode-off)
   (term-mode . (lambda () (setq-local scroll-margin 0)))))

(use-package git-commit
  :preface
  (defun me/git-commit-auto-fill-everywhere ()
    (setq fill-column 72)
    (setq-local comment-auto-fill-only-comments nil))
  :hook
  (git-commit-mode . me/git-commit-auto-fill-everywhere)
  :custom
  (git-commit-summary-max-length 50))

(use-package magit
  :bind
  (:map magit-hunk-section-map
        ("RET" . magit-diff-visit-file-other-window)
        ([return] . magit-diff-visit-file-other-window))
  :custom
  (magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
  (magit-diff-highlight-hunk-body nil)
  (magit-diff-highlight-hunk-region-functions
   '(magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-face))
  (magit-popup-display-buffer-action '((display-buffer-same-window)))
  (magit-refs-show-commit-count 'all)
  (magit-section-show-child-count t)
  :config
  (remove-hook 'magit-section-highlight-hook #'magit-section-highlight))

(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)

;; (use-package company
;;   :bind
;;   (:map company-active-map
;;         ("RET" . nil)
;;         ([return] . nil)
;;         ("TAB" . company-complete-selection)
;;         ([tab] . company-complete-selection)
;;         ("<C-tab>" . company-complete-common))
;;   :hook
;;   (after-init . global-company-mode)
;;   :custom
;;   (company-dabbrev-downcase nil)
;;   (company-idle-delay .2)
;;   (company-minimum-prefix-length 1)
;;   (company-require-match nil)
;;   (company-tooltip-align-annotations t)
;;   :config
;;   (add-to-list 'company-backends 'company-capf)
;;   (setq company-dabbrev-char-regexp "[A-z:-]"))
;; 
;; 
;;  (use-package yasnippet
;;   :bind
;;   (:map yas-minor-mode-map
;;         ("TAB" . nil)
;;         ([tab] . nil)
;;         ("<C-tab>" . yas-expand))
;;   :hook
;;   ((emacs-lisp-mode . yas-minor-mode)
;;    (html-mode . yas-minor-mode)
;;    (js-mode . yas-minor-mode)
;;    (org-mode . yas-minor-mode)
;;    (python-mode . yas-minor-mode)
;;    (LaTeX-mode . yas-minor-mode))
;;   :custom
;;   (yas-snippet-dirs `(,(expand-file-name "snippets/" user-emacs-directory)))
;;   (yas-verbosity 2)
;;   :config
;;   (yas-reload-all))
;; (use-package yasnippet-snippets)

(global-set-key [remap kill-buffer] #'kill-this-buffer)

(use-package edit-server
  :hook (after-init . edit-server-start))

(use-package server
  :ensure nil
  :hook (after-init . server-start))

;; (use-package newcomment
;;   :ensure nil
;;   :bind
;;   ("<M-return>" . comment-indent-new-line)
;;   :custom
;;   (comment-auto-fill-only-comments t)
;;   (comment-multi-line t))

(use-package ediff-wind
  :ensure nil
  :custom
  (ediff-split-window-function #'split-window-horizontally)
  (ediff-window-setup-function #'ediff-setup-windows-plain))

(use-package helm
  :preface
  (defun me/helm-focus-follow ()
    ;; (let ((point (point)))
    ;;   (when (and (pulse-available-p) (> point 1))
    ;;     (pulse-momentary-highlight-one-line point)))
    (recenter-top-bottom (car recenter-positions)))
  (defun me/helm-grab-candidates (beg end)
    (interactive "r")
    (if (region-active-p)
        (kill-ring-save beg end)
      (with-helm-buffer (kill-ring-save (point-min) (point-max)))))
  :bind
  (([remap execute-extended-command] . helm-M-x)
   ([remap find-file] . helm-find-files)
   ([remap isearch-forward] . helm-occur)
   ([remap switch-to-buffer] . helm-buffers-list)
   :map helm-map
   ("<left>" . backward-char)
   ("<right>" . forward-char)
   ("M-w" . me/helm-grab-candidates))
  :hook
  (after-init . helm-mode)
  ;; (helm-after-action . me/helm-focus-follow)
  :custom
  (helm-M-x-fuzzy-match t)
  (helm-always-two-windows t)
  (helm-buffer-max-length nil)
  (helm-buffers-fuzzy-matching t)
  (helm-completion-in-region-fuzzy-match t)
  (helm-display-header-line nil)
  (helm-ff-no-preselect t)
  (helm-ff-skip-boring-files t)
  (helm-find-file-ignore-thing-at-point t)
  (helm-help-full-frame nil)
  (helm-mode-fuzzy-match t)
  (helm-net-prefer-curl (if (executable-find "curl") t nil))
  (helm-org-headings-fontify t)
  (helm-scroll-amount 5)
  (helm-split-window-default-side 'left)
  (helm-truncate-lines t))

(use-package helm-imenu
  :ensure nil
  :bind
  (:map helm-imenu-map
        ("<left>" . backward-char)
        ("<right>" . forward-char)))

(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

(global-set-key (kbd "M-x") 'helm-M-x)
(with-eval-after-load 'helm
  (define-key helm-map (kbd "C-c p") 'ignore)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i")   'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")   'helm-select-action))

(use-package helm-ag
  :bind
  (:map helm-ag-map
        ("<left>" . backward-char)
        ("<right>" . forward-char))
  :custom
  (helm-ag-show-status-function nil))

(use-package helm-descbinds
  :bind
  ([remap describe-bindings] . helm-descbinds)
  :custom
  (helm-descbinds-window-style 'split-window))

(use-package helm-describe-modes
  :bind ([remap describe-mode] . helm-describe-modes))

(use-package helm-org
  :commands helm-org-in-buffer-headings)

(use-package helm-projectile
  :defer nil
  :bind
  (:map helm-projectile-find-file-map
        ("<left>" . backward-char)
        ("<right>" . forward-char))
  :config
  (helm-projectile-toggle 1))

(use-package helm-bibtex
  :ensure t
  :config
  (setq bibtex-completion-pdf-field "file")
  (setq bibtex-completion-bibliography '("/home/gogo/Dropbox/Bibliography/references.bib")) ; my master.bib
  (setq bibtex-completion-library-path '("/home/gogo/Dropbox/Research_papers"))             ; pdf folder
  (setq bibtex-completion-notes-path "/home/gogo/Dropbox/Notes/"))


;(autoload 'helm-bibtex "helm-bibtex" "" t)
;(setq bibtex-completion-bibliography
;      '("/home/gogo/Dropbox/Bibliography/references.bib"))
;(setq bibtex-completion-library-path '("/home/gogo/Dropbox/Research_papers"))
;(setq bibtex-completion-notes-path "/home/gogo/Dropbox/Notes/")

(use-package help-mode
  :ensure nil
  :bind
  (:map help-mode-map
        ("<" . help-go-back)
        (">" . help-go-forward)))

(use-package aggressive-indent
  :preface
  (defun me/aggressive-indent-mode-off ()
    (aggressive-indent-mode 0))
  :hook
  ((css-mode . aggressive-indent-mode)
   (emacs-lisp-mode . aggressive-indent-mode)
   (js-mode . aggressive-indent-mode)
   (lisp-mode . aggressive-indent-mode)
   (sgml-mode . aggressive-indent-mode))
  :custom
  (aggressive-indent-comments-too t)
  :config
  (add-to-list 'aggressive-indent-protected-commands 'comment-dwim))

(use-package highlight-indent-guides
  :hook
  (python-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :bind
  (("M-<backspace>" . sp-unwrap-sexp)
   ("M-<left>" . sp-forward-barf-sexp)
   ("M-<right>" . sp-forward-slurp-sexp)
   ("M-S-<left>" . sp-backward-slurp-sexp)
   ("M-S-<right>" . sp-backward-barf-sexp))
  :hook
  (after-init . smartparens-global-mode)
  :custom
  (sp-highlight-pair-overlay nil)
  (sp-highlight-wrap-overlay nil)
  (sp-highlight-wrap-tag-overlay nil)
  :config
  (show-paren-mode 0)
  (require 'smartparens-config))

(use-package expand-region
  :bind
  ("C-+" . er/contract-region)
  ("C-=" . er/expand-region))

(use-package undo-tree
    :init
    (global-undo-tree-mode))

(use-package which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

(global-set-key [remap backward-paragraph] #'me/backward-paragraph-dwim)
(global-set-key [remap forward-paragraph] #'me/forward-paragraph-dwim)

(defun me/backward-paragraph-dwim ()
  "Move backward to start of paragraph."
  (interactive "^")
  (skip-chars-backward "\n")
  (unless (search-backward-regexp "\n[[:blank:]]*\n" nil t)
    (goto-char (point-min)))
  (skip-chars-forward "\n"))

(defun me/forward-paragraph-dwim ()
  "Move forward to start of next paragraph."
  (interactive "^")
  (skip-chars-forward "\n")
  (unless (search-forward-regexp "\n[[:blank:]]*\n" nil t)
    (goto-char (point-max)))
  (skip-chars-forward "\n"))

(use-package avy)
(global-set-key (kbd "C-;") 'avy-goto-char-2)
(global-set-key (kbd "C-:") 'avy-goto-char-timer)
(setq avy-timeout-seconds 1000)
(global-set-key (kbd "M-g f") 'avy-goto-line)

;;(use-package interleave)

;; (use-package evil-leader
;;   :ensure t
;;   :config
;;   (evil-leader/set-leader "<SPC>")
;;   (global-evil-leader-mode))


;; (use-package evil
;;  :ensure t  ;; install evil if not installed
;;  :init      ;; tweak evil's configuration before loading it
;;  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;;  (setq evil-want-keybinding nil)
;;  (setq evil-vsplit-window-right t)
;;  (setq evil-split-window-below t)
;;  (evil-mode))
;; ;;Evil mode everywhere
;; (use-package evil-collection
;;  :after evil
;;  :ensure t
;;  :config
;;  (evil-collection-init))
;; ;; Evil-org for evil mode in org documents 
;; (use-package evil-org
;;  :commands evil-org-mode
;;  :after org
;;  :init
;;  (add-hook 'org-mode-hook 'evil-org-mode)
;;  :config
;;  (add-hook 'evil-org-mode-hook
;;            (lambda ()
;;              (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
;; (require 'evil-org-agenda)
;; (evil-org-agenda-set-keys)
;; )))

;; (add-hook 'org-mode-hook
;; (lambda ()
;;   (evil-org-mode)

;;   ;; custom mappings
;;   (evil-define-key 'normal evil-org-mode-map
;;     (kbd "-") 'org-ctrl-c-minus
;;     (kbd "|") 'org-table-goto-column
;;     (kbd "m-o") (evil-org-define-eol-command org-insert-heading)
;;     (kbd "m-t") (evil-org-define-eol-command org-insert-todo))

;;   ;; configure leader key
;;   (evil-leader/set-key-for-mode 'org-mode
;;     "." 'hydra-org-state/body
;;     "t" 'org-todo
;;     "t" 'org-show-todo-tree
;;     "v" 'org-mark-element
;;     "a" 'org-agenda
;;     "c" 'org-archive-subtree
;;     "l" 'evil-org-open-links
;;     "c" 'org-resolve-clocks)

;;  ))

;; ;; (use-package evil-org)
;; ;; ;; (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))
;; ;; make movement keys work like they should
;; (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; ;; make horizontal movement cross lines                                    
;; (setq-default evil-cross-lines t)

(defun me/date-iso ()
  "Insert the current date, ISO format, eg. 2016-12-09."
  (interactive)
  (insert (format-time-string "%F")))

(defun me/date-iso-with-time ()
  "Insert the current date, ISO format with time, eg. 2016-12-09T14:34:54+0100."
  (interactive)
  (insert (format-time-string "%FT%T%z")))

(defun me/date-long ()
  "Insert the current date, long format, eg. December 09, 2016."
  (interactive)
  (insert (format-time-string "%B %d, %Y")))

(defun me/date-long-with-time ()
  "Insert the current date, long format, eg. December 09, 2016 - 14:34."
  (interactive)
  (insert (capitalize (format-time-string "%B %d, %Y - %H:%M"))))

(defun me/date-short ()
  "Insert the current date, short format, eg. 2016.12.09."
  (interactive)
  (insert (format-time-string "%Y.%m.%d")))

(defun me/date-short-with-time ()
  "Insert the current date, short format with time, eg. 2016.12.09 14:34"
  (interactive)
  (insert (format-time-string "%Y.%m.%d %H:%M")))

(define-minor-mode my-command-mode
  "my-command-mode is a minor mode for modal editing.

Use `toggle-my-command-mode' to enter and exit the mode.

my-command-mode defines the following bindings:
\\{my-command-mode-map}
"
  ;; initial value
  nil
  ;; indicator for mode line
  " mcm"
  ;; minor mode bindings
  '(((kbd "i") . toggle-my-command-mode)

    ((kbd "j") . next-line)
    ((kbd "k") . previous-line)
    ((kbd "h") . backward-char)
    ((kbd "l") . forward-char)
    ((kbd "(") . backward-sentence)
    ((kbd ")") . forward-sentence)
    ((kbd "L") . forward-word)
    ((kbd "H") . backward-word))
  :group 'mcm-group)

(defun toggle-my-command-mode (&optional set-state)
  "Toggle `my-command-mode', optionally ensuring its state with `SET-STATE'.

`SET-STATE' is interpreted as follows:
  nil   (Same as no argument) Toggle `my-command-mode'
  -1    Ensure `my-command-mode' is disabled
  else  Ensure `my-command-mode' is enabled
"
(interactive)
  (cond ((equal set-state -1)
         (when my-command-mode
           (my-command-mode -1)))

        ((equal set-state nil)
         (my-command-mode (if my-command-mode -1 1)))

        (else
         (unless my-command-mode
           (my-command-mode 1)))))

(global-set-key (kbd "M-+") 'toggle-my-command-mode)

(use-package hydra
  :preface
  (defvar-local me/ongoing-hydra-body nil)
  (defun me/ongoing-hydra ()
    (interactive)
    (if me/ongoing-hydra-body
        (funcall me/ongoing-hydra-body)
      (user-error "me/ongoing-hydra: me/ongoing-hydra-body is not set")))
  :bind
  ("C-c d" . hydra-dates/body)
  ("C-c e" . hydra-eyebrowse/body)
  ("C-c f" . hydra-flycheck/body)
  ("C-c g" . hydra-magit/body)
  ("C-c h" . hydra-helm/body)
  ("C-c o" . me/ongoing-hydra)
  ("C-c p" . hydra-projectile/body)
  ("C-c s" . hydra-system/body)
  ("C-c w" . hydra-windows/body)
  ("C-c r" . hydra-org-roam/body)
  ("C-." . hydra-motion/body)
  :custom
  (hydra-default-hint nil))

(defhydra hydra-dates (:color blue)
  "
^
^Dates^             ^Insert^            ^Insert with Time^
^─────^─────────────^──────^────────────^────────────────^──
_q_ quit            _d_ short           _D_ short
^^                  _i_ iso             _I_ iso
^^                  _l_ long            _L_ long
^^                  ^^                  ^^
"
  ("q" nil)
  ("d" me/date-short)
  ("D" me/date-short-with-time)
  ("i" me/date-iso)
  ("I" me/date-iso-with-time)
  ("l" me/date-long)
  ("L" me/date-long-with-time))

(defhydra hydra-flycheck (:color blue)
  "
^
^Flycheck^          ^Errors^            ^Checker^
^────────^──────────^──────^────────────^───────^───────────
_q_ quit            _<_ previous        _?_ describe
_m_ manual          _>_ next            _d_ disable
_v_ verify setup    _f_ check           _s_ select
^^                  _l_ list            ^^
^^                  ^^                  ^^
"
  ("q" nil)
  ("<" flycheck-previous-error :color pink)
  (">" flycheck-next-error :color pink)
  ("?" flycheck-describe-checker)
  ("d" flycheck-disable-checker)
  ("f" flycheck-buffer)
  ("l" flycheck-list-errors)
  ("m" flycheck-manual)
  ("s" flycheck-select-checker)
  ("v" flycheck-verify-setup))

(defhydra hydra-helm (:color blue)
  "
^
^Helm^              ^Browse^
^────^──────────────^──────^────────────
_q_ quit            _c_ colors
_r_ resume          _g_ google
^^                  _i_ imenu
^^                  _k_ kill-ring
^^                  ^^
"
  ("q" nil)
  ("c" helm-colors)
  ("g" helm-google-suggest)
  ("i" helm-imenu)
  ("k" helm-show-kill-ring)
  ("r" helm-resume))

(defhydra hydra-magit (:color blue)
  "
^
^Magit^             ^Do^
^─────^─────────────^──^────────────────
_q_ quit            _b_ blame
^^                  _c_ clone
^^                  _i_ init
^^                  _s_ status
^^                  ^^
"
  ("q" nil)
  ("b" magit-blame)
  ("c" magit-clone)
  ("i" magit-init)
  ("s" magit-status))

(defhydra hydra-markdown (:color pink)
  "
^
^Markdown^          ^Table Columns^     ^Table Rows^
^────────^──────────^─────────────^─────^──────────^────────
_q_ quit            _c_ insert          _r_ insert
^^                  _C_ delete          _R_ delete
^^                  _M-<left>_ left     _M-<down>_ down
^^                  _M-<right>_ right   _M-<up>_ up
^^                  ^^                  ^^
"
  ("q" nil)
  ("c" markdown-table-insert-column)
  ("C" markdown-table-delete-column)
  ("r" markdown-table-insert-row)
  ("R" markdown-table-delete-row)
  ("M-<left>" markdown-table-move-column-left)
  ("M-<right>" markdown-table-move-column-right)
  ("M-<down>" markdown-table-move-row-down)
  ("M-<up>" markdown-table-move-row-up))

(defhydra hydra-org (:color pink)
  "
^
^Org^               ^Links^             ^Outline^
^───^───────────────^─────^─────────────^───────^───────────
_q_ quit            _i_ insert          _<_ previous
^^                  _n_ next            _>_ next
^^                  _p_ previous        _a_ all
^^                  _s_ store           _o_ goto
^^                  ^^                  _v_ overview
^^                  ^^                  ^^
"
  ("q" nil)
  ("<" org-backward-element)
  (">" org-forward-element)
  ("a" outline-show-all)
  ("i" org-insert-link :color blue)
  ("n" org-next-link)
  ("o" helm-org-in-buffer-headings :color blue)
  ("p" org-previous-link)
  ("s" org-store-link)
  ("v" org-overview))

(defhydra hydra-projectile (:color blue)
  "
^
^Projectile^        ^Buffers^           ^Find^              ^Search^
^──────────^────────^───────^───────────^────^──────────────^──────^────────────
_q_ quit            _b_ list            _d_ directory       _r_ replace
_i_ reset cache     _K_ kill all        _D_ root            _R_ regexp replace
^^                  _S_ save all        _f_ file            _s_ ag
^^                  ^^                  _p_ project         ^^
^^                  ^^                  ^^                  ^^
"
  ("q" nil)
  ("b" helm-projectile-switch-to-buffer)
  ("d" helm-projectile-find-dir)
  ("D" projectile-dired)
  ("f" helm-projectile-find-file)
  ("i" projectile-invalidate-cache :color red)
  ("K" projectile-kill-buffers)
  ("p" helm-projectile-switch-project)
  ("r" projectile-replace)
  ("R" projectile-replace-regexp)
  ("s" helm-projectile-ag)
  ("S" projectile-save-project-buffers))

(defhydra hydra-system (:color blue)
  "
^
^System^            ^Packages^          ^Processes^         ^Shell^
^──────^────────────^────────^──────────^─────────^─────────^─────^─────────────
_q_ quit            _p_ list            _s_ list            _e_ eshell
^^                  _P_ upgrade         ^^                  _t_ term
^^                  ^^                  ^^                  _T_ ansi-term
"
  ("q" nil)
  ("e" (eshell t))
  ("p" paradox-list-packages)
  ("P" paradox-upgrade-packages)
  ("s" list-processes)
  ("t" term)
  ("T" ansi-term))

(defhydra hydra-windows (:color pink)
  "
^
^Windows^           ^Window^            ^Zoom^
^───────^───────────^──────^────────────^────^──────────────
_q_ quit            _b_ balance         _-_ out
^^                  _i_ heighten        _+_ in
^^                  _j_ narrow          _=_ reset
^^                  _k_ lower           ^^
^^                  _l_ widen           ^^
^^                  ^^                  ^^
"
  ("q" nil)
  ("b" balance-windows)
  ("i" enlarge-window)
  ("j" shrink-window-horizontally)
  ("k" shrink-window)
  ("l" enlarge-window-horizontally)
  ("-" text-scale-decrease)
  ("+" text-scale-increase)
  ("=" (text-scale-increase 0)))

;; Define a transient state for quick navigation
  (defhydra hydra-org-state (:color pink)
     "
^
^Navigation^                ^Links^              ^Blocks^                ^Updates^         ^TODO^
^----------^----------------^-----^--------------^------^----------------^-------^---------^----^------------
_q_ quit                    _n_ next link        _N_ next block          _._ C-c C-c       _H_ Increment TODO
_i_ org cycle               _p_ previous link    _P_ previous block      _*_ C-c *         _L_ Decrement TODO
_I_ org-shifttab            _o_ open link        ^^                      _-_ C-c -         _J_ Increase priority
_h_ org-up-element          ^^                   ^^                      ^^                _K_ Decrease priority
_l_ org-down-element        ^^                   ^^                      ^^                _t_ TODO
_j_ org-forward-element     ^^                   ^^                      ^^                ^^
_k_ org-backward-element    ^^                   ^^                      ^^                ^^
"
;; basic navigation
    ("q" nil)
    ("i" org-cycle)
    ("I" org-shifttab)
    ("h" org-up-element)
    ("l" org-down-element)
    ("j" org-forward-element)
    ("k" org-backward-element)
    ;; navigating links
    ("n" org-next-link)
    ("p" org-previous-link)
    ("o" org-open-at-point)
    ;; navigation blocks
    ("N" org-next-block)
    ("P" org-previous-block)
    ;; updates
    ("." org-ctrl-c-ctrl-c)
    ("*" org-ctrl-c-star)
    ("-" org-ctrl-c-minus)
    ;; change todo state
    ("H" org-shiftleft)
    ("L" org-shiftright)
    ("J" org-shiftdown)
    ("K" org-shiftup)
    ("t" org-todo))

;; Define a transient state for inserting org-ref links
  (defhydra hydra-org-ref (:color blue)
  "
^
^Windows^           ^Refer^            ^Cite^
^───────^───────────^─────^────────────^────^──────────────
_q_ quit            _r_ refer          _c_ cite
^^ 
"
  ("q" nil)
  ("r" org-ref-helm-insert-ref-link)
  ("c" org-ref-helm-insert-cite-link))
  ;(evil-leader/set-key-for-mode 'org-mode "r" 'hydra-org-ref/body)

;; Define a transient state for inserting org-ref links
  (defhydra hydra-motion (:color amaranth)
  "
^
^Windows^           ^Motion^                                 ^Mark^
^───────^───────────^──────^─────────────────────────────────^────^──────────────
_q_ quit                       _k_             
^^                 _H_ << _J_ < _h_  _;_  _l_ > _K_ >> _L_               _<SPC>_   Set Mark
^^                             _j_                           _C-<SPC>_ Set Rectangle Mark
^^                                                         _t_       Rectangle Insert
^^
"
  ("q" nil)
  ("j" next-line)
  ("k" previous-line)
  ("l" forward-char)
  ("h" backward-char)
  ("J" forward-word)
  ("K" backward-word)
  ("L" forward-sentence)
  ("H" backward-sentence)
  ("<SPC>" set-mark-command)
  ("C-<SPC>" rectangle-mark-mode)
  (";" avy-goto-char-timer :color blue)
  ("t" string-rectangle :color blue)
  ("y" kill-ring-save "Copy")
  ("d" kill-region "Cut")
  ("p" yank "Paste")
  ("<left>" backward-char)
  ("<right>" forward-char)
  ("<up>" previous-line)
  ("<down>" next-line)
  ("u" undo "Undo"))
(global-set-key (kbd "C-.") 'hydra-motion/body)

;; Define a transient state for inserting org-roam links
  (defhydra hydra-org-roam (:color blue)
  "
^
^Windows^           ^Node^             ^Sync^
^───────^───────────^─────^────────────^────^──────────────
_q_ quit              _c_ Capture          _s_ Sync
                    _i_ Insert           _t_ Buffer toggle
                    _f_ Find
^^ 
"
  ("q" nil)
  ("t" org-roam-buffer-toggle)
  ("s" org-roam-db-sync)
  ("i" org-roam-node-insert)
  ("f" org-roam-node-find)
  ("c" org-roam-capture))
  ;(evil-leader/set-key-for-mode 'org-mode "r" 'hydra-org-ref/body)
