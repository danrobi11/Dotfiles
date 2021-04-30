;; https://github.com/daviwil/dotfiles
;; https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/doom/config.el
;; https://www.emacswiki.org/emacs/SiteMap
;; https://github.com/seagle0128/doom-modeline
;; http://blog.idorobots.org/entries/system-monitor-in-emacs-mode-line.html
;; https://cestlaz.github.io/
;; https://github.com/zamansky/using-emacs
;; http://www.shedai.net/ai/tutorial.html
;; http://ergoemacs.org/emacs/emacs.htmlhttps://melpa.org/
;; https://github.com/ch11ng/exwm/wiki/Configuration-Example
;; https://sachachua.com/dotemacs
;; open 
;; create new file = find file command
;; zoom it/out # text-scale-increase/decrease
;; install all the emacs icon # M-x all-the-icons-install-fonts
;; bookmark-set # save bookmark | bookmark-jump # load saved bookmark | bookmark-delete
;; describe-key # C-h k
;; refresh package list # package-refresh-contents
;; update packages # M-x auto-package-update-now
;; capitalize-word # alt-c
;; reload init file # load-file
;; C-h f when prompt over lisp line of code to show description
;; Press o to open a folder in a separate window
;; calendar # i-d add-a-dairy| d show-dairy | x show-holidays | m show-mark-days | u hide-mark-days-and-holidays | h show-holiday-description
;; themes | doom-homage-black | doom-moonlight | doom-challenger-deep
(defun load-history-filename-element (file-regexp)
  (let* ((loads load-history)
   (load-elt (and loads (car loads))))
    (save-match-data
      (while (and loads
      (or (null (car load-elt))
          (not (stringp (car load-elt)))
          (not (string-match file-regexp (car load-elt)))))
  (setq loads (cdr loads)
        load-elt (and loads (car loads)))))
    load-elt))
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;;(use-package exwm
;;  :ensure t
;;  :config
;;  (require 'exwm)
;;  (require 'exwm-config)
;;  (exwm-config-example)
;;  (require 'exwm-systemtray)
;;  (exwm-systemtray-enable))
(use-package zoom
  :ensure t
  :init
  (setq zoom-size '(80 . 80))
  (zoom-mode))
(use-package persp-mode
  :ensure t
  :init
  (persp-mode))
(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-homage-black t))
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode))
(use-package counsel
  :ensure t
  :init
  (counsel-mode))  
(use-package auto-package-update
  :ensure t)
(use-package elpher
  :ensure t)
(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/bash"))
(use-package dashboard
  :ensure t
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "🐧 Hello Master 🐧")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;;(setq dashboard-startup-banner "~/.emacs.d/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  :config
  (dashboard-setup-startup-hook))
(use-package page-break-lines
  :ensure t
  :init
  (page-break-lines-mode))
(use-package emoji-cheat-sheet-plus
  :ensure t
  :init )
(use-package emojify
  :ensure t
  :init
  (global-emojify-mode 1))
;;(use-package dmenu
;;  :ensure t
;;  :init )
(use-package elfeed
  :ensure t
  :config
  (load (expand-file-name "/home/danrobi/.elfeed/elfeed.el")))
;;
(debug-on-entry t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(auto-save-mode 1)
(auto-save-visited-mode 1)
(display-battery-mode 1)
(display-time-mode 1)
(save-place-mode 1)
(global-visual-line-mode 1)
(global-hl-line-mode 1)
(mouse-avoidance-mode 1)
(ido-mode 1)
;; (mode-line-debug-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers t)
 '(display-time-day-and-date t)
 '(display-time-format nil)
 '(display-time-use-mail-icon t)
 '(mouse-avoidance-mode (quote banish) nil (avoid))
 '(package-selected-packages
   (quote
    (multi-term emojify emoji-fontset dashboard elpher zoom vterm auto-package-update persp-mode helm elfeed doom-themes doom-modeline counsel)))
 '(window-min-height 6))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; keybinds
;;(global-set-key (kbd "\C-x\C-b") 'buffer-menu-other-window)
;;(global-set-key (kbd "\C-x\b") 'switch-to-buffer-other-window)
(global-set-key (kbd "<C-tab>") 'other-window)
(define-prefix-command 'z-map)
(global-set-key (kbd "C-z") 'z-map)
(define-key z-map (kbd "b") 'eww)
(define-key z-map (kbd "e") 'elfeed)
(define-key z-map (kbd "u") 'elfeed-update)
(define-key z-map (kbd "s") 'bookmark-set)
(define-key z-map (kbd "j") 'bookmark-jump)
(define-key z-map (kbd "d") 'bookmark-delete)
(define-key z-map (kbd "z") 'buffer-menu-other-window)
;;(define-key z-map (kbd "k") 'kill-this-buffer)
;;(bind-key "<C-tab>" 'other-window)
;;(global-set-key (kbd "C-q") 'kill-this-buffer)
;;(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/")))
;;(bind-key "<f2> <right>" 'windmove-right)
;;(defun config-visit ()
;;  (interactive)
;;  (find-file "/home/danrobi/.emacs.d/init.el"))
;;(global-set-key (kbd "C-c d") 'config-visit)
