(add-variable-watcher 'the-var-to-be-watched
                       (lambda (sym new-value operation where)
                           (message "Value for %s getting modified to %s with %s in buffer %s"
                                    sym new-value operation where)))

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")) ;;  (add-to-list approach preserves the default gnu elpa value in the list as well)
(package-refresh-contents)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package exwm ;; require xelb
  :ensure t
  :init
  :config
  (exwm-enable)
  (require 'exwm-systemtray)
  (setq exwm-systemtray-height '18)
  (exwm-systemtray-enable))

;; Elfeed is a web feed client for Emacs
(use-package elfeed
  :ensure t
  :config
  (load (expand-file-name "/home/danrobi/.elfeed/elfeed.el"))
  (setq-default elfeed-search-filter "@1-week-ago +unread ")
  (set-face-background 'elfeed-search-title-face "snow")
  (set-face-foreground 'elfeed-search-title-face "black")
  (set-face-background 'elfeed-search-unread-title-face "black")
  (set-face-foreground 'elfeed-search-unread-title-face "snow")
  (setq-default elfeed-search-title-max-width '135)
(defun elfeed-mark-all-as-read ()
  "Mark all unread feeds as read"
      (interactive)
      (elfeed-untag 'elfeed-search-entries 'unread)
      (elfeed-search-update :force))) ; redraw

(use-package erc
  :ensure t
  :config
  (load (expand-file-name "/home/danrobi/.emacs.d/.ercrc.el"))
  (erc-notify-mode) ;; notification in mode-line
  (erc-notifications-mode) ;; desktop notification
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (setq erc-fill-column '95)
  (erc-fill-mode)
  (global-set-key (kbd "C-x t") 'erc-track-switch-buffer))

(use-package elpher
  :ensure t
  :init)

;;(use-package selectrum
;;  :ensure t
;;  :init)
;;  (selectrum-mode))

;;(use-package counsel
;;  :ensure t
;;  :init
;;  (counsel-mode))

(use-package ace-window
  :ensure t
  :init)
;;  :bind (("<insert>" . ace-window)))

(use-package emoji-cheat-sheet-plus
  :ensure t
  :init)

;;(use-package which-key
;;  :ensure t
;;  :init)

(use-package emojify
  :ensure t
  :init
  (global-emojify-mode))

(use-package ctrlf
  :ensure t
  :init
  (ctrlf-mode))

(use-package marginalia ;;  
  :ensure t
  :init
  (marginalia-mode))

(use-package auto-package-update
  :ensure t
  :init)

;; Emacs Customization
(delete-selection-mode)
(face-spec-set 'mode-line-inactive '((t :inherit modeline)))
(face-spec-set 'mode-line-inactive '((t (:box))))
(face-spec-set 'mode-line '((t (:box))))
(winner-mode 1)
(fringe-mode 0)
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(display-time-mode 1)
(line-number-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(pixel-scroll-mode -1)
(global-auto-revert-mode 1)
(setq display-time-day-and-date 1)
(setq display-time-default-load-average 'none)
(setenv "EDITOR" "emacsclient")

;; Open url link with eww
(setq browse-url-browser-function 'eww-browse-url)

;; Backgrounds
(defun snow-background ()
  "Snow Background"
  (interactive)
  (set-face-background #'mode-line-inactive "snow")
  (set-face-foreground #'mode-line-inactive "black")
  (set-face-background #'mode-line "blue violet")
  (set-face-foreground #'mode-line "snow")
  (set-face-foreground #'vertical-border "snow")
  (set-background-color "snow")
  (set-foreground-color "black"))

(defun lightsteelblue4-background ()
  "LightSteelBlue4 Background"
  (interactive)
  (set-face-background #'mode-line-inactive "LightSteelBlue4")
  (set-face-foreground #'mode-line-inactive "snow")
  (set-face-background #'mode-line "blue violet")
  (set-face-foreground #'mode-line "snow")
  (set-face-foreground #'vertical-border "LightSteelBlue4")
  (set-background-color "LightSteelBlue4")
  (set-foreground-color "snow"))

(defun lightsteelblue4-background ()
  "LightSteelBlue4 Background"
  (interactive)
  (set-face-background #'mode-line-inactive "LightSteelBlue4")
  (set-face-foreground #'mode-line-inactive "snow")
  (set-face-background #'mode-line "blue violet")
  (set-face-foreground #'mode-line "snow")
  (set-face-foreground #'vertical-border "LightSteelBlue4")
  (set-background-color "LightSteelBlue4")
  (set-foreground-color "snow"))

(defun black-background ()
  "Black Background"
  (interactive)
  (set-face-background #'mode-line-inactive "black")
  (set-face-foreground #'mode-line-inactive "snow")
  (set-face-background #'mode-line "SlateBlue4")
  (set-face-foreground #'mode-line "snow")
  (set-face-foreground #'vertical-border "black")
  (set-background-color "black")
  (set-foreground-color "snow"))

;; (:background "blue-violet" :foreground "snow" :box "0" :weight "ultra-light" :height "0.9"))

;; set env path
(setq exec-path '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/27.1/x86_64-linux-gnu" "/usr/share" "/var/lib/" "/home/danrobi"))

;; Keybinds
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save) ;; copy
(global-set-key (kbd "C-y") 'clipboard-yank) ;; paste
(global-set-key (kbd "C-w") 'clipboard-kill-region) ;; cut
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x t") 'erc-track-switch-buffer) ;; switch to next erc-buffer new message
(global-set-key (kbd "C-c <left>") 'winner-undo)
(global-set-key (kbd "C-c <right>") 'winner-redo)
(global-set-key (kbd "C-x w") 'ace-window)

(global-set-key (kbd "C-x <f5>") (lambda() (interactive)(load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-x <f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-x <f7>") (lambda() (interactive)(find-file "/home/danrobi")))
(global-set-key (kbd "C-x <f8>") (lambda() (interactive)(find-file "/media/danrobi/1tbstorage")))

;; Aliases
(defalias 'oeh 'org-html-export-to-html)
(defalias 'ttl 'toggle-truncate-lines)
(defalias 'asc 'async-shell-command)
(defalias 'rb 'rename-buffer)
(defalias 'otld 'org-toggle-link-display)

;; New Functions
(defun lbry ()
  "LBRY AppImage"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./LBRY_0.51.1.AppImage"))

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

(defun netsurf ()
  "NetSurf Browser"
  (interactive)
  (async-shell-command "flatpak run org.netsurf_browser.NetSurf"))

(defun freetube ()
  "FreeTube"
  (interactive)
  (async-shell-command "flatpak run io.freetubeapp.FreeTube"))

(defun handbrake ()
  "HandBrake Encoder"
  (interactive)
  (async-shell-command "flatpak run fr.handbrake.ghb"))

(defun xonotic ()
  "Xonotic Shooter Game"
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/Xonotic/./xonotic-linux64-glx"))

;; Package List
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(emacs-emoji-cheat-sheet emoji-cheat-sheet-plus emojify auto-package-update ctrlf ace-window marginalia use-package exwm elpher elfeed)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
