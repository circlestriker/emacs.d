;; -*- mode: elisp -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/elisp/")
(package-initialize)
;; Disable the splash screen (to enable it agin, replace the t with 0)

(recentf-mode 1)
(setq recentf-max-saved-items 500)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;;(run-at-time nil (* 5 60) 'recentf-save-list)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(setq inhibit-splash-screen t)

(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(global-set-key (kbd "C-c c") 'pbcopy)
(global-set-key (kbd "C-c v") 'pbpaste)
(global-set-key (kbd "C-c x") 'pbcut)

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(evil-search-module (quote evil-search))
 '(package-selected-packages
   (quote
    (kill-ring-search projectile vue-mode window-numbering window-number find-file-in-project magit smex ggtags flymake-php flymake-easy auto-complete php-mode evil web-mode ## undo-tree)))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "GPATH" "GRTAGS" "GTAGS" "storage/framework"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
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

(defun ffip-diff-mode-hook-setup ()
    (evil-local-set-key 'normal "K" 'diff-hunk-prev)
    (evil-local-set-key 'normal "J" 'diff-hunk-next)
    (evil-local-set-key 'normal "P" 'diff-file-prev)
    (evil-local-set-key 'normal "N" 'diff-file-next)
    (evil-local-set-key 'normal (kbd "RET") 'ffip-diff-find-file)
    (evil-local-set-key 'normal "o" 'ffip-diff-find-file))
(add-hook 'ffip-diff-mode-hook 'ffip-diff-mode-hook-setup)

;; if the full path of current file is under SUBPROJECT1 or SUBPROJECT2
;; OR if I'm reading my personal issue track document,
(defun my-setup-develop-environment ()
  (interactive)
  (when (ffip-current-full-filename-match-pattern-p "\\(wx-admin-platform\\)")
    ;; Though PROJECT_DIR is team's project, I care only its sub-directory "subproj1""
    ;;(setq-local ffip-project-root "~/projs/PROJECT_DIR/subproj1")
    ;; well, I'm not interested in concatenated BIG js file or file in dist/
    (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/database/*' -not -iwholename '*/vendor/*' -not -iwholename '*/storage/*'")
    ;; for this project, I'm only interested certain types of files
    (setq-local ffip-patterns '("*.html" "*.css" "*.java" "*.xml" "*.php"))
    ;; ignore files whose name match certain glob pattern
    (setq-local ffip-ignore-filenames '("*.bmp" "*.jpg"))
    ;; exclude `dist/' directory
    (add-to-list 'ffip-prune-patterns "*/GTAGS")
    (add-to-list 'ffip-prune-patterns "*/GRTAGS")
    (add-to-list 'ffip-prune-patterns "*/GPATH"))
    ;;(add-to-list 'ffip-prune-patterns '("*/GPATH" "*/GRTAGS" "*/GTAGS" "*/database" "*/dist" )))
  ;; insert more WHEN statements below this line for other projects
)
;; most major modes inherit from prog-mode, so below line is enough
(add-hook 'prog-mode-hook 'my-setup-develop-environment)

(which-function-mode 1)

;;(setq ffip-project-root "/Users/win/wj/wx-admin-platform/app")

(require 'window-number)
(window-number-mode 1)
(window-number-meta-mode)
(global-set-key (kbd "C-x o") 'window-number-switch)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(setq make-backup-files nil) ; stop creating backup~ files

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.wxml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.wxss?\\'" . web-mode))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(autoload 'kill-ring-search "kill-ring-search"
 "Search the kill ring in the minibuffer."
 (interactive))
(global-set-key "\M-\C-y" 'kill-ring-search)
