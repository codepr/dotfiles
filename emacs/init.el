;;; init.el --- Codep's configuration entry point.
;;; Commentary:
;; This file contain my personal emacs configuration
;;; code:

(setq user-full-name "Andrea Giacomo Baldan"
      user-mail-address "a.g.baldan@gmail.com")
;; fix KDE font bug
(setq initial-frame-alist '((font . "Source Code Pro-10")))
(setq default-frame-alist '((font . "Source Code Pro-10")))
;; start maximized
(toggle-frame-maximized)
;; make scratch buffer empty
;;(setq initial-scratch-message "")
;; remove *messages* buffer
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; encoding UTF-8
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
;; convert any change made on file to the current buffer
(global-auto-revert-mode)
;; no backup
(setq make-backup-files nil)
;; delete trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; window settings
(when window-system
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1))
;; global font lock maximum level
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
;; set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))
;; show keystroke in progress
(setq echo-keystrokes 0.1)
;; open transparently compressed files
(auto-compression-mode t)
;; show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)
;; easily navigate silly case words
(global-subword-mode 1)
;; don't break lines
(setq-default truncate-lines t)
;; better word-wrapping
(visual-line-mode 1)
;; auto fill
(auto-fill-mode 1)
;; preservative scroll, C-v and M-v returns cursor to the same position
(setq scroll-preserve-screen-position 'always)
;; 8' chars len lines
(setq-default fill-column 80)
;; display numbers
(global-linum-mode 0)
;; highlight current line
(global-hl-line-mode 1)
;; sentences ending with one space
(setq sentence-end-double-space nil)
;; yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)
;; reduce frequency of garvage collector
(setq gc-cons-threshold 50000000)
;; elpa packages archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
;; startup installation control packages
(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode-20140616.115/")
;; add to load-path conf folder for personal configurations
(add-to-list 'load-path (expand-file-name "~/.emacs.d/conf/"))
;; add load-path
(add-to-list 'load-path "~/.emacs.d/elpa/")
(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
;; required packages
(require 'package)
(require 'ace-jump-mode)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'yasnippet)
(require 'autopair)
(require 'web-mode)
(require 'emmet-mode)
(require 'conf-func)
(require 'conf-latex)
(require 'conf-ido)
(require 'markdown-mode)
(require 'indent-guide)
(require 'flycheck)
(require 'which-key)
(require 'ensime)
(require 'linum)
(require 'browse-kill-ring)
(require 'ibuffer)
(with-no-warnings
  (require 'cl))
(setq package-enable-at-startup nil)
(package-initialize)
;; allow custom themes
(setq custom-safe-themes t)
;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
;; ibuffer sort by major mode
(setq ibuffer-default-sorting-mode 'major-mode)
;; ace-jump shortcurt
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(defvar url-http-attempt-keepalives 'url-http-attempt-keepalives nil)
(defvar codep-packages
  '(auto-complete markdown-mode evil yasnippet atom-one-dark-theme autopair emmet-mode
                  evil-leader evil-nerd-commenter guide-key indent-guide js2-mode
                  key-chord linum-relative python-mode smex web-mode flycheck
                  ido-vertical-mode which-key tao-theme ensime ace-jump-mode helm)
  "List of packages to ensure are installed at launch.")

(defun codep-packages-installed-p ()
  "Check installed packages and install missing ones."
  (loop for p in codep-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (codep-packages-installed-p)
  (message "%s" "Refreshing now package database...")
  (package-refresh-contents)
  (message "%s" "done.")
  (dolist (p codep-packages)
    (when (not (package-installed-p p))
      (package-install p))))
;; RET autoindent
(define-key global-map (kbd "RET") 'newline-and-indent)
(ac-config-default)
(global-auto-complete-mode t)
;; snippets path
(setq yas-snippet-dirs '("~/.emacs.d/elpa/yasnippet-20151108.1505/snippets/"))
(yas-global-mode 1)
;; fix scroll, make it smooth
(setq scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000)
;; indent style
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode nil)
;; autopair parethesys
(autopair-global-mode 1)
(setq autopair-autowrap t)
;; web-mode setup
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
;; emmet-mode setup
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
;; position cursor between first empty quotes after expanding
(setq emmet-move-cursor-between-quotes t)
(defvar auto-indent-assign-indent-level 'auto-indent-assign-indent-level 4)
;; js-mode 2 spaces tab width
(defvar js-indent-level 2)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(frame-background-mode (quote light))
 '(indicate-empty-lines nil)
 '(inhibit-startup-screen t)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default))))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; load evil configuration
(defun evil-start ()
  "Switch to evil mode."
  (interactive)
  (require 'conf-evil))
;; split buffers resize
;; (global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)
;; treat java directives like comments
(add-hook 'java-mode-hook
          (lambda ()
            "Treat Java 1.5 @-style annotations as comments."
            (defvar java-mode-syntax-table)
            (defvar c-comment-start-regexp "(@|/(/|[*][*]?))")
            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))
;; org-mode export to Markdown option
(eval-after-load "org"
  '(require 'ox-md nil t))
;; indent guide
(indent-guide-global-mode)
;; flycheck tool
(setq flycheck-emacs-lisp-load-path 'inherit)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; which-key helper
(which-key-mode)
(global-undo-tree-mode)
;; (powerline-default-theme)
(defvar powerline-default-separator 'wave)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; ensime enhanced scala mode
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; load stock theme
(load-theme 'stock t)

;;; init.el ends here
