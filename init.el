(setq user-full-name "Ian Weatherhogg")
(setq user-mail-address "ian@ianweatherhogg.com")

(require 'cask (expand-file-name "emacs-cask/cask.el" user-emacs-directory))
(cask-initialize)

(require 'use-package)

(setq inhibit-splash-screen t)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(display-time-mode t)
(column-number-mode t)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)

;; cask
(add-to-list 'auto-mode-alist '("\\Cask\\'" . emacs-lisp-mode))

;; cvs
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))

(require 'dired+) ;; before resurrect desktop for buffer colour
(require 'highlight-parentheses)

(use-package desktop
  :config (setq desktop-files-not-to-save "\\(^/[^/:]*:\\|(ftp)$\\|\\.gpg$\\)")
  :init (desktop-save-mode 1))

(use-package uniquify
  :config (setq uniquify-buffer-name-style 'forward))

(defun disable-all-themes ()
  "Disable all active themes."
  (interactive)
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
  (disable-all-themes))

(setq custom-safe-themes t)

(use-package tango-plus-theme
  :init (load-theme 'tango-plus t))

(use-package solarized
  :init
  (progn
    (setq solarized-use-variable-pitch nil
          solarized-height-minus-1 1.0
          solarized-height-plus-1 1.0
          solarized-height-plus-2 1.0
          solarized-height-plus-3 1.0
          solarized-height-plus-4 1.0)))

(use-package smartparens
  :init (require 'smartparens-config))

(use-package ace-jump-mode
  :bind (("C-; SPC" . ace-jump-mode)))

(use-package powerline
  :init
  (powerline-default-theme))

(global-hl-line-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'text-mode-hook 'flyspell-mode)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))

(setq backup-directory-alist
      `((".*" . ,(expand-file-name "backup/" user-emacs-directory))))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "backup/" user-emacs-directory) t)))

(global-auto-revert-mode 1)

(use-package rainbow-delimiters
  :config
  (progn
    (set-face-foreground 'rainbow-delimiters-depth-1-face "blue") ;; orginally white
    (set-face-foreground 'rainbow-delimiters-depth-2-face "tomato")
    (set-face-foreground 'rainbow-delimiters-depth-3-face "sienna")
    (set-face-foreground 'rainbow-delimiters-depth-4-face "coral")
    (set-face-foreground 'rainbow-delimiters-depth-5-face "orange")
    (set-face-foreground 'rainbow-delimiters-depth-6-face "purple")
    (set-face-foreground 'rainbow-delimiters-depth-7-face "turquoise")
    (set-face-foreground 'rainbow-delimiters-depth-8-face "cyan")
    (set-face-foreground 'rainbow-delimiters-depth-9-face "goldenrod")
    (set-face-foreground 'rainbow-delimiters-unmatched-face "red")
    ))

(use-package ruby-mode
  :config
  (progn
    (setq ruby-align-to-stmt-keywords t))
  :mode
  (("\\.rake\\'"     . ruby-mode)
   ("Rakefile\\'"    . ruby-mode)
   ("\\.gemspec\\'"  . ruby-mode)
   ("\\.ru\\'"       . ruby-mode)
   ("Gemfile\\'"     . ruby-mode)
   ("Guardfile\\'"   . ruby-mode)
   ("Capfile\\'"     . ruby-mode)
   ("\\.thor\\'"     . ruby-mode)
   ("Thorfile\\'"    . ruby-mode)
   ("Vagrantfile\\'" . ruby-mode)
   ("\\.jbuilder\\'" . ruby-mode)))

(use-package epa
  :init
    (progn
       (require 'epa)
       (require 'epa-file)))

(use-package ido-at-point
  :init
  (progn
    (ido-at-point-mode)))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer)))

;; purescript
(add-to-list 'auto-mode-alist '("\\.purs\\'" . haskell-mode))

(use-package helm-swoop
  :bind (("M-i" . helm-swoop)))

(use-package expand-region
  :init
  (require 'expand-region)
  :bind (("C-=" . er/expand-region)))

(bind-key "C-c w r" 'winner-redo)
(bind-key "C-c w w" 'winner-undo)

(bind-key "RET" 'newline-and-indent)
;; (bind-key "M-SPC" 'set-mark-command)
;; (bind-key "M-s-SPC" 'mark-sexp)

(bind-key "<f5>" 'comment-or-uncomment-region)

(use-package tramp
  :init (require 'tramp)
  :config
    (progn)
      (tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "~/.ssh/config"))))

(use-package ace-window
  :bind (("C-x o" . ace-window)))

(use-package buffer-move
  :bind (("<C-S-up>"    . buf-move-up)
         ("<C-S-down>"  . buf-move-down)
         ("<C-S-left>"  . buf-move-left)
         ("<C-S-right>" . buf-move-right)))

(use-package hippie-exp
  :bind (("M-/" . hippie-expand)))

(use-package ido
  :init (ido-mode 1)
  :config
  (progn
    (setq ido-enable-prefix nil
          ido-enable-flex-matching t
          ido-everywhere t
          ido-create-new-buffer 'always
          ido-use-filename-at-point 'guess
          ido-max-prospects 10
          ido-default-file-method 'selected-window
          ido-auto-merge-work-directories-length -1
          ido-use-virtual-buffers t)
    (add-to-list 'ido-ignore-buffers "\\`*tramp/")))

(use-package ido-ubiquitous
  :init
  (ido-ubiquitous-mode 1))

(use-package lisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook
            '(lambda ()
               (turn-on-eldoc-mode))))

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (progn
    (require 'magit-svn)
    (add-hook 'magit-mode-hook 'turn-on-magit-svn)

    (defun magit-ignore-latex-project ()
      (interactive)
      (mapc
       #'magit-ignore-file
       (list "*.aux" "*.log" "*.out" "*.bbl" "*.blg" "auto/" "*.synctex.gz" "*.toc"))
      (magit-refresh))))

(use-package org
  :bind (("C-c o a" . org-agenda)
         ("C-c o b" . org-iswitchb)
         ("C-c o c" . org-capture)
         ("C-c o l" . org-store-link))
  :config
  (progn
    (require 'org-capture)

    (add-hook 'org-mode-hook 'auto-fill-mode)
    (setq org-src-fontify-natively t)
    (setq org-src-preserve-indentation t)

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (perl . t)
       (python . t)
       (ruby . t)
       (scala . t)
       (sh . t)))))

(use-package recentf
  :init (recentf-mode 1)
  :config
  (progn
    ;; Enable recentf mode with ido-mode support
    ;;
    ;; http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/

    ;; Increase size of recent file list
    (setq recentf-max-saved-items 50)

    ;; Ignore ephemeral git commit message files
    (add-to-list 'recentf-exclude "/COMMIT_EDITMSG$")
    ;; Ignore temporary notmuch ical files
    (add-to-list 'recentf-exclude "^/tmp/notmuch-ical")

    (defun ido-recentf-open ()
      "Use `ido-completing-read' to \\[find-file] a recent file"
      (interactive)
      (if (find-file (ido-completing-read "Find recent file: " recentf-list))
          (message "Opening file...")
        (message "Aborting")))))

(use-package savehist
  :init (savehist-mode 1))

(use-package scala-mode2
  :mode
  (("\\.sc\\'" . scala-mode)))

(add-hook 'scala-mode-hook
            (lambda ()
              (setq imenu-generic-expression
                    '(
                      ("var" "\\(var +\\)\\([^(): ]+\\)" 2)
                      ("val" "\\(val +\\)\\([^(): ]+\\)" 2)
                      ("override def" "^[ \\t]*\\(override\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                      ("private def" "^[ \\t]*\\(private\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                      ("implicit def" "^[ \\t]*\\(implicit\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                      ("def" "^[ \\t]*\\(def +\\)\\([^(): ]+\\)" 2)
                      ("trait" "\\(trait +\\)\\([^(): ]+\\)" 2)
                      ("class" "^[ \\t]*\\(class +\\)\\([^(): ]+\\)" 2)
                      ("case class" "^[ \\t]*\\(case class +\\)\\([^(): ]+\\)" 2)
                      ("abstract class" "^[ \\t]*\\(abstract class +\\)\\([^(): ]+\\)" 2)
                      ("object" "\\(object +\\)\\([^(): ]+\\)" 2)
                      ))))

(use-package server
  :init
  (unless (server-running-p)
    (server-start)))

(use-package smex
  :bind ("M-x" . smex)
  :config
  (progn
    (smex-initialize)))

(use-package guide-key
  :diminish guide-key-mode
  :idle
  (progn
    (setq guide-key/guide-key-sequence '("C-x 4" "C-c h" "C-x c"))
    (guide-key-mode 1)))

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package winner
  :init
  (setq winner-boring-buffers '("*Completions*"
                                "*Compile-Log*"
                                "*inferior-lisp*"
                                "*Fuzzy Completions*"
                                "*Apropos*"
                                "*dvc-error*"
                                "*Help*"
                                "*cvs*"
                                "*Buffer List*"
                                "*Ibuffer*"
                                ))
  (winner-mode 1))

(use-package zoom-frm
  :bind (("C-c C-+" . zoom-in/out)
         ("C-c C--" . zoom-in/out)
         ("C-c C-0" . zoom-in/out)
         ("C-c C-=" . zoom-in/out)))

(use-package smartscan
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'smartscan-mode)))

(use-package twittering-mode
  :init
  (setq twittering-number-of-tweets-on-retrieval 60)
  (setq twittering-use-master-password t))

(use-package helm
  :bind (("C-`" . helm-buffers-list)
;;         ("C-c h f" . helm-firefox-bookmarks)
         ("C-1" . helm-find-files)
         ("C-c h g" . helm-git-grep-from-here)
;;         ("C-c h p" . helm-projectile)
         ("C-q" . helm-M-x))
  :config
  (progn
    (require 'helm-config))
    (setq helm-split-window-default-side 'right))
;;     (add-to-list 'helm-for-files-preferred-list 'helm-source-ls-git t)
;;     (delete 'helm-source-locate helm-for-files-preferred-list)
;;     (helm-attrset 'follow 1 helm-source-buffers-list)

;;       (helm-adaptative-mode 1)))
(use-package eshell
  :bind ("M-e" . eshell)
  :init
  (add-hook 'eshell-first-time-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "htop")))
  :config
  (progn
    (setq eshell-history-size 5000)
    (setq eshell-save-history-on-exit t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(bookmark-default-file (expand-file-name "~/Documents/sync/bookmarks"))
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "chromium")
 '(custom-enabled-themes (quote (tango-plus)))
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "f5e9f66da69f504cb61aacedeb8284d8f38f2e6f835fd658cac5f0ad5d924549" default)))
 '(delete-by-moving-to-trash t)
 '(electric-pair-mode t)
 '(history-length 10000)
 '(indent-tabs-mode nil)
 '(blink-cursor-mode nil)
 '(org-agenda-files (quote ("~/Documents/sync/org/")))
 '(org-directory "~/Documents/sync/org")
 '(require-final-newline t)
 '(dired-dwim-target t) ;; guesses target when copy/move dired mode
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(sentence-end-double-space nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "DejaVu Sans"))))
 '(fixed-pitch ((t (:family "DejaVu Sans Mono"))))
 '(linum ((t (:inherit (shadow default) :weight light))))
 '(org-checkbox ((t (:inherit (bold fixed-pitch)))))
 '(org-document-title ((t (:weight bold :height 1.4))))
 '(org-level-1 ((t (:height 1.3))))
 '(org-level-2 ((t (:height 1.2))))
 '(org-level-3 ((t (:height 1.1))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(show-paren-match ((t (:background "#fce94f"))) t)
 '(variable-pitch ((t (:family "DejaVu Sans"))))
 '(whitespace-indentation ((t (:background "LightYellow" :foreground "firebrick")))))
