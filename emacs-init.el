;; https://github.com/daviwil/dotfiles
;; https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/doom/config.el
;; https://www.emacswiki.org/emacs/SiteMap
;; https://github.com/seagle0128/doom-modeline
;; http://blog.idorobots.org/entries/system-monitor-in-emacs-mode-line.html
;; https://cestlaz.github.io/
;; https://github.com/zamansky/using-emacs
;; bookmark-set # save bookmark
;; bookmark-jump # load saved bookmark
;; describe-key
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
(debug-on-entry t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(counsel-mode 1)
(doom-modeline-mode 1)
(persp-mode 1)
(auto-save-mode 1)
(auto-save-visited-mode 1)
(display-battery-mode 1)
(display-time-mode 1)
(mode-line-bell-mode 1)
;; (mode-line-debug-mode 1)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(load-theme 'doom-dracula t)
(add-to-list 'load-path "/home/danrobi/common-lisp/emacs-libvterm")
(require 'vterm)
(global-set-key (kbd "\C-x\C-b") 'buffer-menu-other-window)
(global-set-key (kbd "\C-x\b") 'switch-to-buffer-other-window)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers t)
 '(display-time-day-and-date t)
 '(display-time-format nil)
 '(display-time-use-mail-icon t)
 '(package-selected-packages
   '(zoom vterm mode-line-debug mode-line-bell auto-package-update workgroups persp-mode persist helm elfeed doom-themes doom-modeline counsel))
 '(vterm-always-compile-module t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; keybinds
(define-prefix-command 'z-map)
(global-set-key (kbd "C-x <up>") 'other-window)
(global-set-key (kbd "C-z") 'z-map)
(define-key z-map (kbd "b") 'eww)
(define-key z-map (kbd "e") 'elfeed)
(define-key z-map (kbd "s") 'bookmark-set)
(define-key z-map (kbd "j") 'bookmark-jump)
(define-key z-map (kbd "d") 'bookmark-delete)
(define-key z-map (kbd "z") 'zoom)
;; elfeed
                   
