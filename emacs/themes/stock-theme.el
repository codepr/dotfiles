(deftheme stock
  "Created 2015-12-04.")

(custom-theme-set-faces
 'stock
 '(font-lock-comment-face ((t (:foreground "Firebrick" :slant italic))))
 '(region ((t (:background "gray80" :distant-foreground "gtk_selection_fg_color"))))
 '(default ((t (:background "gray95" :foreground "gray7")))))

(provide-theme 'stock)
