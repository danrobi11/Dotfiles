;;; package --- Summary
;;; Commentary:
;;; Code:
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

(use-package exwm ;; require xelb
  :ensure t
  :config
  (require 'exwm)
  (require 'exwm-config)
  (exwm-config-example)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable))

(use-package selectrum ;; completing-read are provided by consult.
  :ensure t
  :config
  '(selectrum-mode))

(use-package counsel
  :ensure t
  :init
  (counsel-mode))

(use-package which-key ;; 
  :ensure t
  :config
  (which-key-setup-side-window-right)
;;  (which-key-setup-minibuffer)
;;  (setq which-key-popup-type 'side-window)
  (which-key-mode))

(use-package dmenu ;; require nadvice-0.3
  :ensure t
  :init )

(load-theme 'manoj-dark 1)
(display-time-mode 1)
(global-visual-line-mode 1)
(global-hl-line-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 1)
(menu-bar-mode -1)
;; (auto-save-mode 1)

(global-set-key (kbd "C-x C-b") 'buffer-menu-other-window) ;; open the buffer-list menu in another window
(global-set-key (kbd "C-x r") 'browse-kill-ring) ;;  open all the saved clipboard stuff buffer
(global-set-key (kbd "C-y") 'yank) ;; paste
(global-set-key (kbd "C-w") 'kill-region) ;; cut
(global-set-key (kbd "M-w") 'kill-ring-save) ;; copy
(global-set-key (kbd "C-x u") 'undo) ;; undo
(global-set-key (kbd "C-x s") 'exwm-input-send-next-key) ;; send command to the external window
(global-set-key (kbd "C-x d") 'dmenu)
(global-set-key (kbd "C-s") 'ctrlf-forward-default) ;; find word. isearch
(global-set-key (kbd "C-x t") 'erc-track-switch-buffer) ;; go to irc channel with new message
(global-set-key (kbd "C-x C-z") 'other-window) ;; switch to the next buffer
(global-set-key (kbd "C-x 0") 'delete-window) ;; remove the current window. does not kill/delete the window
(global-set-key (kbd "C-x 1") 'delete-other-windows) ;; remove all the other windows
(global-set-key (kbd "C-x C-k") 'kill-this-buffer) ;; this kill/delete the window
(global-set-key (kbd "C-x b") 'eww) ;; open the eww browser
(global-set-key (kbd "C-x C-a") 'next-buffer)
(global-set-key (kbd "C-x C-d") 'previous-buffer)
;;(global-set-key (kbd "C-x <down>") 'rotate-frame-clockwise) ;; require transpose-frame
(global-set-key (kbd "C-g") 'keyboard-quit) ;; quit/ close minibuffer stuff
(global-set-key (kbd "C-SPC") 'set-mark-command) ;; set mark | "C-SPC SPC" to cancel set mark
(global-set-key (kbd "M-x") 'counsel-M-x) ;; Open the execute-command minibuffer.
(global-set-key (kbd "C-x C-v") 'counsel-switch-buffer-other-window)
(global-set-key (kbd "C-x C-c") 'ibuffer) ;; counsel-switch-buffer, ibuffer
(global-set-key (kbd "<f5>") (lambda() (interactive)(load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(find-file "/home/danrobi")))
(global-set-key (kbd "<f8>") (lambda() (interactive)(find-file "/media/danrobi/1tbstorage/FilesTransferFolder")))
(defun qtox.sh ()
  (interactive)
  (async-shell-command "/home/danrobi/.local/bin/./qtox.sh &"))

;; Personal Prefix-Command (kbd "C-z")
(define-prefix-command 'z-map)
(global-set-key (kbd "C-z") 'z-map)
(define-key 'z-map (kbd "s") 'bookmark-set)
(define-key 'z-map (kbd "j") 'bookmark-jump)
(define-key 'z-map (kbd "d") 'bookmark-delete)
(global-set-key (kbd "C-x e") 'elfeed) ;; open elfeed
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-visited-mode t)
 '(display-time-day-and-date t)
 '(dmenu-prompt-string "Dmenu: ")
 '(exec-path
   '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/lib/emacs/27.1/x86_64-linux-gnu" "/home/danrobi/.local/bin"))
 '(global-hl-line-mode t)
 '(global-visual-line-mode t)
 '(ibuffer-always-show-last-buffer :nomini)
 '(ibuffer-use-other-window nil)
 '(ido-max-window-height 0.5)
 '(ivy-fixed-height-minibuffer t)
 '(ivy-height 30)
 '(line-number-mode nil)
 '(max-mini-window-height 0.5)
 '(mode-line-percent-position '(6 "%q"))
 '(package-selected-packages
   '(selectrum-prescient dmenu which-key use-package selectrum exwm emojify elpher dashboard ctrlf counsel browse-kill-ring))
 '(selectrum-fix-vertical-window-height t)
 '(selectrum-max-window-height 30)
 '(selectrum-mode t)
 '(which-key-mode t)
 '(which-key-side-window-max-height 0.5)
 '(which-key-side-window-max-width 0.5))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "blue violet" :foreground "snow" :box nil :weight bold :height 0.9))))
 '(mode-line-buffer-id ((t (:background "blue violet" :foreground "snow" :weight ultra-light :height 0.9))))
 '(mode-line-inactive ((t (:background "black" :foreground "snow" :box nil :weight ultra-light :height 0.9)))))
