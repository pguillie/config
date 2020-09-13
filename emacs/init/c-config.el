;; C config

(setq-default
 c-default-style "linux"
 c-backspace-function 'backward-delete-char)

(c-set-offset 'brace-list-intro '+)
(c-set-offset 'brace-list-entry '0)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-cont 0)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-close 0)

(require 'ac-c-headers)
(add-hook 'c-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-c-headers)
            (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))
