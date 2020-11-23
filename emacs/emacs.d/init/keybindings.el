;; Keybindings

(global-set-key (kbd "DEL") 'backward-delete-char)

(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-x .") 'other-window)
(global-set-key (kbd "C-x ,") 'prev-window)

(global-set-key (kbd "M-s M-s") 'sr-speedbar-toggle)
(global-set-key (kbd "M-s s") 'sr-speedbar-select-window)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
