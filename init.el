(setq user-full-name "Ian Weatherhogg")
(setq user-mail-address "ian@ianweatherhogg.com")

(require 'cask (expand-file-name "emacs-cask/cask.el" user-emacs-directory))
(cask-initialize)

(require 'use-package)
