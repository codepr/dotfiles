;;; conf-func.el --- Codep's custom functions.
;;; Commentary:
;; This file contain my personal emacs enhanced functions.
;;; code:

(require 'eclim)
(require 'eclimd)
;; regular auto-complete
(ac-config-default)
;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(setq help-at-pt-display-when-idle t
      help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(custom-set-variables
 '(eclim-eclipse-dirs '("/usr/lib/eclipse"))
 '(eclim-executable "/usr/lib/eclipse/eclim")
 '(eclimd-executable "/usr/lib/eclipse/eclimd"))

(setq eclimd-wait-for-process nil
      eclimd-default-workspace "~/workspace-eclim"
      eclim-use-yasnippet nil
      eclim-auto-save nil)

;; eclim mode
(add-hook 'java-mode-hook
          '(lambda ()
             (remove 'ac-source-clang 'ac-sources)
             (eclim-mode t)))

(provide 'conf-eclim)

;;; conf-eclim.el ends here
