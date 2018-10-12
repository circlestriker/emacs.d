;; -*- mode: elisp -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/elisp/")
(package-initialize)
;; Disable the splash screen (to enable it agin, replace the t with 0)

(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(setq inhibit-splash-screen t)


;;start mac设置剪切板共享
(defun copy-from-osx ()
(shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
(let ((process-connection-type nil))
(let ((proc (start-process"pbcopy" "*Messages*" "pbcopy")))
(process-send-string proc text)
(process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)
;;end 设置剪切板共享

;; Enable transient mark mode
(transient-mark-mode 1)

(require 'evil)
(evil-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (vue-mode sicp geben window-numbering window-number find-file-in-project magit smex ggtags flymake-php flymake-easy auto-complete php-mode evil ## undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;(global-visual-line-mode t)
(global-linum-mode 1)

(ac-config-default)

(require 'flymake-php)
(add-hook 'php-mode-hook 'flymake-php-load)


(require 'smex) ; Not needed if you use package.el
;;(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(defadvice find-name-dired (before find-name-dired-with-default-directory activate)
  "change the argument reading"
  (interactive
   (let ((default-directory "/Users/win/wj/wx-admin-platform"))
     (call-interactively 'get-args-for-my-find-name-dired))))

(defun get-args-for-my-find-name-dired (dir pattern)
  (interactive "DFind-name (directory): \nsFind-name (filename wildcard): ")
  (list dir pattern))

(defun ffip-diff-mode-hook-setup ()
    (evil-local-set-key 'normal "K" 'diff-hunk-prev)
    (evil-local-set-key 'normal "J" 'diff-hunk-next)
    (evil-local-set-key 'normal "P" 'diff-file-prev)
    (evil-local-set-key 'normal "N" 'diff-file-next)
    (evil-local-set-key 'normal (kbd "RET") 'ffip-diff-find-file)
    (evil-local-set-key 'normal "o" 'ffip-diff-find-file))
(add-hook 'ffip-diff-mode-hook 'ffip-diff-mode-hook-setup)

(which-function-mode 1)

(setq ffip-project-root "/Users/win/wj/wx-admin-platform/app")

(require 'window-number)
(window-number-mode 1)
(window-number-meta-mode)
(global-set-key (kbd "C-x o") 'window-number-switch)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(setq make-backup-files nil) ; stop creating backup~ files
