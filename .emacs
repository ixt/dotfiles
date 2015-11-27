(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(package-selected-packages
   (quote
    (quack geiser markdown-mode markdown-mode+ paredit scheme-complete epresent processing-mode monokai-theme color-theme evil-escape evil-org evil-smartparens evil-tabs nlinum magit org helm evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 (require 'package)

 (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
 (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
 (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

 (defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

 Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
 (or (file-exists-p package-user-dir)
    (package-refresh-contents)) 

 (setq package-enable-at-startup nil)
 (package-initialize)
 (require 'color-theme)
 (color-theme-initialize)
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
 (load-theme 'monokai t)
 (defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Monospace-20"))

;; Fontify current frame
 (fontify-frame nil)
;; Fontify any future frames
 (push 'fontify-frame after-make-frame-functions)

 (require 'evil)
 (evil-mode t)
 (global-linum-mode 1)
 (tool-bar-mode 0)
 (scroll-bar-mode 0)
 (menu-bar-mode 0)
 (blink-cursor-mode 0)
 (setq make-backup-files nil)
 (setq auto-save-default nil)

 (show-paren-mode t)

 (setq processing-location "/usr/bin/processing-java")
 (setq processing-application-dir "/usr/bin/processing") 
 (setq processing-sketchbook-dir "~/Downloads/Projects")

 (setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "x-www-browser")
