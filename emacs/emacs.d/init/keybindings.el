;; Keybindings

;; navigation
(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-x .") 'other-window)
(global-set-key (kbd "C-x ,") 'prev-window)
