;;; conf-evil.el --- Codep's vim-like controls.
;;; Commentary:
;; This file contain my personal emacs vim-like shortcuts.
;;; code:
;; ctrl-U behave like vim
(setq evil-want-C-u-scroll t)
;; evil-leader before evil
(require 'evil-leader)
(global-evil-leader-mode)
;; evil-mode vim emulation
(evil-mode 1)
;; evil-mode leader key
(evil-leader/set-leader ",")
(evil-leader/set-key
  "w" 'save-buffer
  "c" 'evilnc-comment-or-uncomment-lines)
;; key-chord for jk / kj normal mode
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
;; prevent evil from overwriting cursor color
(setq evil-default-cursor t)
(setq evil-cross-lines t)
;; relative numbers
(with-eval-after-load 'linum
  (set-face-background 'linum nil)

  (require 'linum-relative)
  ;; truncate current line to four digits
  (defun linum-relative (line-number)
	(let* ((diff1 (abs (- line-number linum-relative-last-pos)))
		   (diff (if (minusp diff1)
					 diff1
				   (+ diff1 linum-relative-plusp-offset)))
		   (current-p (= diff linum-relative-plusp-offset))
		   (current-symbol (if (and linum-relative-current-symbol current-p)
							   (if (string= "" linum-relative-current-symbol)
								   (number-to-string (% line-number 1000))
								 linum-relative-current-symbol)
							 (number-to-string diff)))
		   (face (if current-p 'linum-relative-current-face 'linum)))
	  (propertize (format linum-relative-format current-symbol) 'face face)))

  (setq
   linum-relative-current-symbol ""
   linum-relative-format "%3s "
   linum-delay t)

  (set-face-attribute 'linum-relative-current-face nil
					  :weight 'extra-bold
					  :foreground nil
					  :background nil
					  :inherit '(hl-line default)))
(linum-relative-mode 1)
;; j/k for browsing wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; C-j and C-k scrolling
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
												(interactive)
												(evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
												(interactive)
												(evil-scroll-down nil)))
;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
	  (setq deactivate-mark  t)
	(when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
	(abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
;;; conf-evil.el ends here
