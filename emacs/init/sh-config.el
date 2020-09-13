;; Shell config

(defun prg-sh-mode ()
  (interactive)
  (setq sh-basic-offset 8
        sh-indentation 8))
(add-hook 'sh-mode-hook 'prg-sh-mode)
