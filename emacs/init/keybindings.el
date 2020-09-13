;; Keybindings

;; delete: don't change tabs into spaces
(global-set-key (kbd "DEL") 'backward-delete-char)

;; navigation
(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-x .") 'other-window)
(global-set-key (kbd "C-x ,") 'prev-window)

;; jump to definition
(global-set-key (kbd "C-j") 'dumb-jump-go)
(global-set-key (kbd "M-j") 'dumb-jump-back)
