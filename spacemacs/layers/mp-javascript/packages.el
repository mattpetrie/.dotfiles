;;; packages.el --- React-enhanced Javascript Layer packages File for Spacemacs

;; Copyright (c) 2018 Matt Petrie & Contributors
;;
;; Author: Matt Petrie <matthew.petrie@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq mp-javascript-packages
  `(
    eslintd-fix
    evil-matchit
    flycheck
    graphql-mode
    js2-refactor
    json-mode
    json-snatcher
    rjsx-mode
    tide
    ))

(defun mp-javascript/post-init-flycheck ()
  (dolist (mode '(graphql-mode json-mode rjsx-mode))
    (spacemacs/add-flycheck-hook mode)))

(defun mp-javascript/post-init-evil-matchit ()
  (add-hook 'rjsx-mode-hook 'turn-on-evil-matchit-mode))

(defun mp-javascript/post-init-prettier ()
  (dolist (mode '(graphql-mode-hook json-mode-hook rjsx-mode-hook))
    (add-hook mode 'prettier-js-mode)))

(defun mp-javascript/post-init-eslintd ()
  (dolist (mode '(graphql-mode-hook json-mode-hook rjsx-mode-hook))
    (add-hook mode 'eslintd-fix-mode)))

(defun mp-javascript/post-init-tide ()
  (add-hook 'rjsx-mode-hook #'spacemacs/setup-tide-mode)
  (setq company-tooltip-align-annotations t))

(defun mp-javascript/init-rjsx-mode ()
  (use-package rjsx-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))
    :config
    (progn
      ;; prefixes
      (spacemacs/declare-prefix-for-mode 'rjsx-mode "mz" "folding")
      (spacemacs/declare-prefix-for-mode 'rjsx-mode "mr" "refactor")
      (spacemacs/declare-prefix-for-mode 'rjsx-mode "mt" "tide")
      (spacemacs/declare-prefix-for-mode 'rjsx-mode "mtR" "rename")
      (spacemacs/declare-prefix-for-mode 'rjsx-mode "mtd" "docs")
      ;; key bindings
      (spacemacs/set-leader-keys-for-major-mode 'rjsx-mode
        "zc" 'js2-mode-hide-element
        "zo" 'js2-mode-show-element
        "zr" 'js2-mode-show-all
        "ze" 'js2-mode-toggle-element
        "zF" 'js2-mode-toggle-hide-functions
        "zC" 'js2-mode-toggle-hide-comments
        "tx" 'tide-fix
        "tr" 'tide-refactor
        "ti" 'tide-organize-imports
        "tf" 'tide-references
        "tj" 'tide-jump-to-definition
        "tZ" 'tide-restart-server
        "tV" 'tide-verify-setup
        "tRs" 'tide-rename-symbol
        "tRf" 'tide-rename-file
        "tdt" 'tide-jsdoc-template
        "tdd" 'tide-documentation-at-point
        ))))

(defun mp-javascript/init-js2-refactor ()
  (use-package js2-refactor
  :defer t
  :init
  (progn
    (add-hook 'rjsx-mode-hook 'spacemacs/js2-refactor-require)
    ;; prefixes
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mr3" "ternary")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mra" "add/args")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrb" "barf")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrc" "contract")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mre" "expand/extract")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mri" "inline/inject/introduct")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrl" "localize/log")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrr" "rename")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrs" "split/slurp")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrt" "toggle")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mru" "unwrap")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrv" "var")
    (spacemacs/declare-prefix-for-mode 'rjsx-mode "mrw" "wrap")
    ;; key bindings
    (spacemacs/set-leader-keys-for-major-mode 'rjsx-mode
      "r3i" 'js2r-ternary-to-if
      "rag" 'js2r-add-to-globals-annotation
      "rao" 'js2r-arguments-to-object
      "rba" 'js2r-forward-barf
      "rca" 'js2r-contract-array
      "rco" 'js2r-contract-object
      "rcu" 'js2r-contract-function
      "rea" 'js2r-expand-array
      "ref" 'js2r-extract-function
      "rem" 'js2r-extract-method
      "reo" 'js2r-expand-object
      "reu" 'js2r-expand-function
      "rev" 'js2r-extract-var
      "rig" 'js2r-inject-global-in-iife
      "rip" 'js2r-introduce-parameter
      "riv" 'js2r-inline-var
      "rlp" 'js2r-localize-parameter
      "rlt" 'js2r-log-this
      "rrv" 'js2r-rename-var
      "rsl" 'js2r-forward-slurp
      "rss" 'js2r-split-string
      "rsv" 'js2r-split-var-declaration
      "rtf" 'js2r-toggle-function-expression-and-declaration
      "ruw" 'js2r-unwrap
      "rvt" 'js2r-var-to-this
      "rwi" 'js2r-wrap-buffer-in-iife
      "rwl" 'js2r-wrap-in-for-loop
      "k" 'js2r-kill
      "j" 'js2r-move-line-down
      "k" 'js2r-move-line-up))))

(defun mp-javascript/init-tide ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1)
;;   (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
;;   (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
;;   (setq company-tooltip-align-annotations t)
;;   )
  (use-package tide
    :ensure t
    :config
    (progn
      (setq flycheck-check-syntax-automatically '(save mode-enabled))
      (setq company-tooltip-align-annotations t)
      (add-hook 'rjsx-mode-hook #'spacemacs/setup-tide-mode))))
  ;; (use-package tide
  ;;   :ensure t
  ;;   :after (rjsx-mode company flycheck eldoc)
  ;;   :config
  ;;   (progn
  ;;     (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  ;;     (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)
  ;;     (setq flycheck-check-syntax-automatically '(save mode-enabled))
  ;;   :hook ((rjsx-mode . tide-setup)
  ;;          (rjsx-mode . tide-hl-identifier-mode))))

(defun mp-javascript/init-eslintd-fix ()
  (use-package eslintd-fix
    :defer t))

(defun mp-javascript/init-graphql-mode ()
  (use-package graphql-mode
    :defer t))

(defun mp-javascript/init-json-mode ()
  (use-package json-mode
    :defer t))

(defun mp-javascript/init-json-snatcher ()
  (use-package json-snatcher
    :defer t
    :config
    (spacemacs/set-leader-keys-for-major-mode 'json-mode
      "hp" 'jsons-print-path)))
