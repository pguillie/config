(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq package-list
      '(company
	eglot
	helm
	magit
	markdown-mode
	monokai-theme
	nasm-mode
	sr-speedbar
	yasnippet))
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(when (version<= "26.0.50" emacs-version )
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.s\\'" . nasm-mode))

(defun indent-sh-mode ()
  (interactive)
  (setq sh-basic-offset 8
        sh-indentation 8))
(add-hook 'sh-mode-hook 'indent-sh-mode)

(load-theme 'monokai t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/init/")
(load "keybindings.el")
