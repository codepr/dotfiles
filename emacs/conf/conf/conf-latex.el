;;; conf-latex.el --- Codep's configuration for latex exporting documents.
;;; Commentary:
;; This file contain my personal org2latex configuration.
;;; code:
(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass[10pt,a4paper]{article}
                \\usepackage[utf8]{inputenc}
                \\usepackage{alltt}
                \\usepackage{caption}
                \\usepackage{hyperref}
                \\usepackage{listings}
                \\usepackage{xcolor}
                \\usepackage{graphicx}
                \\usepackage{lmodern}
                \\usepackage[top=2in, bottom=1.5in, left=0.7in, right=0.7in]{geometry}
                \\DeclareCaptionFormat{listing}{\\rule{\\dimexpr\\textwidth+17pt\\relax}{0.4}\\vskip1pt#1#2#3}
                \\captionsetup[lstlisting]{singlelinecheck=false, margin=0pt, font={bf,footnotesize}}
                \\definecolor{wine-stain}{rgb}{0.4,0.3,0.3}
                \\hypersetup{colorlinks,linkcolor=wine-stain,linktoc=all}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; PDFs visited in Org-mode are opened in Okular (and not in the default choice) http://stackoverflow.com/a/8836108/789593
(add-hook 'org-mode-hook
          '(lambda ()
             (delete '("\\.pdf\\'" . default) org-file-apps)
             (add-to-list 'org-file-apps '("\\.pdf\\'" . "okular %s"))))

(provide 'conf-latex)
;;; conf-latex.el ends here
