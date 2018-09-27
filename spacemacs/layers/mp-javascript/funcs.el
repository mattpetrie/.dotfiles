;;; funcs.el --- React-enhanced Javascript Layer packages File for Spacemacs
;;
;; Copyright (c) 2018 Matt Petrie & Contributors
;;
;; Author: Matt Petrie <matthew.petrie@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; js-refactor
(defun spacemacs/js2-refactor-require ()
  "Lazy load js2-refactor"
  (require 'js2-refactor))

;; tide
(defun spacemacs/setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
  )
