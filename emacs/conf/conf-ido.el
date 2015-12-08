;;; conf-ido.el --- Codep's custom ido settings.
;;; Commentary:
;; This file contain my personal emacs ido settings.
;;; code:

(require 'smex)
(require 'ido)
(require 'ido-vertical-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(require 'ido-hacks nil t)
(if (commandp 'ido-vertical-mode)
    (progn
      (ido-vertical-mode 1)
      (defvar ido-vertical-define-keys 'C-n-C-p-up-down-left-right)))
(if (commandp 'smex)
    (global-set-key (kbd "M-x") 'smex))
(if (commandp 'flx-ido-mode)
    (flx-ido-mode 1))

(provide 'conf-ido)

;;; conf-ido.el ends here
