(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package exwm ;; require xelb
  :ensure t
  :init
  :config
    (exwm-enable)
;;  (require 'exwm)
;;  (require 'exwm-config)
;;  (exwm-config-example)
;;  (setq exwm-floating-border-width '-t)
  (require 'exwm-systemtray)
  (setq exwm-systemtray-height '18)
  (exwm-systemtray-enable))

;; Elfeed is a web feed client for Emacs
(use-package elfeed
  :ensure t
  :config
  (load (expand-file-name "/home/danrobi/.elfeed/elfeed.el"))
  (setq-default elfeed-search-filter "@1-week-ago +unread "))
(defun my-elfeed-mark-all-read ()
  "Mark all unread feeds as read"
      (interactive)
      (elfeed-untag 'elfeed-search-entries 'unread)
      (elfeed-search-update :force)) ; redraw

(use-package erc
  :ensure t
  :config
  (load (expand-file-name "/home/danrobi/.emacs.d/.ercrc.el"))
  (erc-notify-mode) ;; notification in mode-line
  (erc-notifications-mode) ;; desktop notification
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (global-set-key (kbd "C-x t") 'erc-track-switch-buffer))

(use-package elpher
  :ensure t
  :init)

(use-package selectrum
  :ensure t
  :init
  (selectrum-mode))

(use-package ace-window
  :ensure t
  :config
  :bind (("C-x C-o" . ace-window)))

(use-package which-key
  :ensure t
  :init)

(use-package ctrlf
  :ensure t
  :init
  (ctrlf-mode))

(use-package marginalia ;;  
  :ensure t
  :init
  (marginalia-mode))

;; Emacs Customization
(fringe-mode -1)
;; (set-fringe-mode -1)
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(display-time-mode 1)
(line-number-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq display-time-day-and-date 1)
(setq display-time-default-load-average 'none)

;; This sets the mode-line customization
(defun my-config ()
  "My Config"
  (interactive)
  (set-face-background #'mode-line-inactive "snow")
  (set-face-foreground #'mode-line-inactive "black")
  (set-face-background #'mode-line "black")
  (set-face-foreground #'mode-line "snow"))

;; (:background "blue-violet" :foreground "snow" :box "0" :weight "ultra-light" :height "0.9"))

;; set env path
(setq exec-path '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/27.1/x86_64-linux-gnu" "/usr/share" "/var/lib/" "/home/danrobi"))

;; Keybinds
(global-set-key (kbd "C-x C-v") 'switch-to-buffer) ;; buffer-list in minibuffer
(global-set-key (kbd "M-w") 'selectrum-kill-ring-save) ;; copy
(global-set-key (kbd "C-y") 'clipboard-yank) ;; paste
(global-set-key (kbd "C-w") 'clipboard-kill-region) ;; cut
(global-set-key (kbd "C-x t") 'erc-track-switch-buffer) ;; switch to next erc-buffer new message
;; (global-set-key (kbd "C-x C-o") 'ace-window)

(global-set-key (kbd "<f5>") (lambda() (interactive)(load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(find-file "/home/danrobi")))
(global-set-key (kbd "<f8>") (lambda() (interactive)(find-file "/media/danrobi/1tbstorage")))

;; Aliases
(defalias 'oeh 'org-html-export-to-html)
(defalias 'ttl 'toggle-truncate-lines)
(defalias 'asc 'async-shell-command)
(defalias 'rb 'rename-buffer)

;; New Functions
(defun qtox ()
  "qTox AppImage"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./qTox-v1.17.3.x86_64.AppImage"))

(defun status ()
  "Status AppImage"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./StatusIm-Desktop-v0.1.0-beta.10-06484e.AppImage"))

(defun twitch ()
  "Twitch AppImage"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./streamlink-twitch-gui-v1.11.0-x86_64.AppImage"))

(defun sc-controller ()
  "Sc-Controller AppImage"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./sc-controller-0.4.7.glibc-x86_64.AppImage"))

;; Package List
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ctrlf ace-window marginalia which-key use-package exwm elpher elfeed)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
