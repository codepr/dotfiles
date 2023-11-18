(setq user-full-name "Andrea Baldan"
      user-mail-address "a.g.baldan@gmail.com")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(toggle-frame-maximized)

(set-frame-font "Liga SFMono Nerd Font 13")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq package-check-signature nil)

(setq-default indent-tabs-mode nil)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

(require 'ido-vertical-mode)
(ido-mode t)
(ido-vertical-mode t)
(ido-everywhere t)
(setq ido-enabled-flex-matching t)
(setq ido-use-filename-at-point t)
(setq ido-use-virtual-buffers t)
(setq ido-auto-merge-work-directories-length 0)

(global-set-key "\C-x\C-x" 'execute-extended-command)

(setq initial-major-mode 'text-mode)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)   ;; Show/hide startup page
(setq initial-scratch-message t) ;; Show/hide *scratch* buffer message

(when window-system
  (menu-bar-mode -1)                  ;; Show/hide menubar
  (tool-bar-mode -1)                  ;; Show/hide toolbar
  (tooltip-mode  -1)                  ;; Show/hide tooltip
  (scroll-bar-mode -1))                ;; Show/hide scrollbar

(icomplete-mode t)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
(setq sentence-end-double-space nil)
(setq-default fill-column 79)
(global-font-lock-mode t)
(setq scroll-error-top-bottom t)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")
(setq echo-keystrokes 0.1)
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)
;; don't break lines
(setq-default truncate-lines t)
;; better word-wrapping
(visual-line-mode 1)
(auto-fill-mode 1)
(setq scroll-preserve-screen-position 'always)
;; fix scroll, make it smooth
(setq scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000)
(setq make-backup-files nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4
              indent-tabs-mode nil)

                                        ; Erase whitespaces
(add-hook 'before-save-hook 'whitespace-cleanup)

                                        ; Packages
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package ido-vertical-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq flycheck-check-syntax-automatically '(save mode-enable)))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode)
  ;; ac behaviour
  (eval-after-load 'company
    '(progn
       (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
       (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
       (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
       (define-key company-active-map (kbd "<backtab>") 'company-select-previous))))

(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package move-text
  :ensure t)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(use-package smartparens
  :ensure t)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(cc-mode . ("clangd"))))

(add-hook 'cc-mode-hook 'eglot-ensure)

;; Customization
(defun my/move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.
If point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'my/move-beginning-of-line)

(defun my/indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun my/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (my/indent-buffer)
        (message "Indented buffer.")))
    (whitespace-cleanup)))

(global-set-key (kbd "C-c i") 'my/indent-region-or-buffer)

(defun my/smart-open-line ()
  "Insert an empty line after he current line.
Position the cursor at it's beginning."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun my/smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursors at it's beginning."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "C-o") 'my/smart-open-line)
(global-set-key (kbd "M-o") 'my/smart-open-line-above)

(defun my/comment-or-uncomment-region ()
  "Comment or uncomment a region.
Comment the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-c c") 'my/comment-or-uncomment-region)

(defun my/kill-ring-save ()
  "Copy the region selected or the current line if no region is active."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (kill-ring-save beg end)))

(global-set-key (kbd "M-w") 'my/kill-ring-save)

(defun my/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(defun my/cc-mode-before-save-format ()
  "Format using LSP"
    (eglot-format-buffer))

(add-hook 'cc-mode-hook
          (lambda () (add-hook 'before-save-hook 'my/cc-mode-before-save-format nil 'local)))

(global-set-key (kbd "C-,") 'my/duplicate-line)

(customize-set-variable 'timu-macos-flavour "dark")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(timu-macos))
 '(custom-safe-themes
   '("30df7ea949ac3764ad6c885f1dc1a32209987598b6e42bfc5f443e45f5d87f84" default))
 '(package-selected-packages
   '(clojure-ts-mode ido-vertical-mode vertico move-text eglot timu-macos-theme which-key use-package smartparens magit flycheck company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
