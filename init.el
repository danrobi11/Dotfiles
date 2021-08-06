(add-variable-watcher 'the-var-to-be-watched
                       (lambda (sym new-value operation where)
                           (message "Value for %s getting modified to %s with %s in buffer %s"
                                    sym new-value operation where)))

;;(require 'package)
;;(add-to-list 'package-archives
;;	     '("melpa" . "https://melpa.org/packages/")) ;;  (add-to-list approach preserves the default gnu elpa value in the list as well)
;;(package-refresh-contents)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name)) ;; required by exwm add-hook

(use-package exwm ;; require xelb
  :ensure t
  :init
  :config
;;  (exwm-enable)
;;  (require 'exwm)
;;  (require 'exwm-config)
;;  (exwm-config-example)
  ;;  (setq exwm-floating-border-width '-t)
  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class) ;; auto rename buffer with app name
  (require 'exwm-systemtray)
  (setq exwm-systemtray-height '18)
  (exwm-systemtray-enable))

;; Elfeed is a web feed client for Emacs
(use-package elfeed
  :ensure t
  :init
  :config
  (load (expand-file-name "/home/danrobi/.elfeed/elfeed.el"))
  (setq-default elfeed-search-filter "@1-week-ago +unread ")
  (set-face-background 'elfeed-search-title-face "snow")
  (set-face-foreground 'elfeed-search-title-face "black")
  (set-face-background 'elfeed-search-unread-title-face "black")
  (set-face-foreground 'elfeed-search-unread-title-face "snow")
  (setq-default elfeed-search-title-max-width '145)
(defun elfeed-mark-all-as-read ()
  "Mark all unread feeds as read"
      (interactive)
      (elfeed-untag 'elfeed-search-entries 'unread)
      (elfeed-search-update :force))) ; redraw

(use-package erc
  :ensure nil
  :init
  :config
  (load (expand-file-name "/home/danrobi/.emacs.d/.ercrc.el"))
  (erc-notify-mode) ;; notification in mode-line
  (erc-notifications-mode) ;; desktop notification
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (setq erc-fill-column '200)
  (setq-default erc-default-server "irc.libera.chat")
;;  (setq erc-header-line '0)
  (erc-fill-mode)
  (global-set-key (kbd "C-x t") 'erc-track-switch-buffer))

(use-package elpher
  :ensure t
  :init
  :config
  (setq elpher-gemini-max-fill-width '200))

;;(use-package selectrum
;;  :ensure t
;;  :init)
;;  (selectrum-mode))

;;(use-package counsel
;;  :ensure t
;;  :init
;;  (counsel-mode))

;;(use-package ace-window
;;  :ensure t
;;  :init)
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
  :config
  (global-emojify-mode))

(use-package ctrlf
  :ensure t
  :init
  :config
  (ctrlf-mode))

(use-package marginalia ;;  
  :ensure t
  :init
  :config
  (marginalia-mode))

(use-package auto-package-update
  :ensure t
  :init)

;; Emacs Customization
;;(face-spec-set 'vertical-border-face '((t :background black)))
;;(setq fringe-styles '("no-fringes" . 0))
;;(setq 'fringe-styles '("no-fringes" . 0))
(delete-selection-mode)
;;(face-spec-set 'vertical-border '((t :inherit modeline)))
(face-spec-set 'mode-line-inactive '((t :inherit modeline)))
(face-spec-set 'mode-line-inactive '((t (:box))))
(face-spec-set 'mode-line '((t (:box))))
(winner-mode 1)
(fringe-mode 0)
(ido-mode 1)
(setq ido-separator "\n")
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)
(blink-cursor-mode -1)
(auto-save-mode -1)
(auto-save-visited-mode -1) ;; autosave new edited buffers
(tool-bar-mode -1)
(display-time-mode 1)
(line-number-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(pixel-scroll-mode -1)
(global-auto-revert-mode 1)
(setq display-time-day-and-date 1)
(setq display-time-default-load-average 'nil)
(setq mode-line-in-non-selected-windows 't)
(setenv "EDITOR" "emacsclient")
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; mouse scroll one line at a time
(setq scroll-conservatively '1) ;; keyboard scroll one line at the time
(setq shr-inhibit-images '0) ;; disable displaying images in eww and elfeed
(setq fill-region 'center)
(setq async-shell-command-buffer 'new-buffer)
(setq url-privacy-level 'paranoid) ;; don’t send anything
(setq exwm-manage-force-tiling 't) ;; prevent apps to launch in floating buffer

;; ibuffer display name only
(setq ibuffer-formats '((mark " " name)
       (mark modified read-only
             (name 16 16 :left)
             (size 6 -1 :right))))

;;(ace-window-display-mode 1) ;; ace-window buffer number in the modeline
;;(setq aw-display-mode-overlay nil) ;; ace-window buffer number in the overlay
;;(setq aw-background nil) ;; ace-window overlay on/off

;; Open url link with eww
(setq browse-url-browser-function 'eww-browse-url)

;; other browser setup
;;(setq browse-url-browser-function 'browse-url-firefox) ;; #'browse-url-firefox
;;(setq browse-url-firefox-program "netsurf")
;;(setq browse-url-browser-function 'browse-url-default-browser)
;;dbus-send --type=method_call --dest=org.netsurf_browser.NetSurf

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

;; Personal Prefix-Command (kbd "C-z")

(define-prefix-command 'z-map)
(global-set-key (kbd "C-z") 'z-map)
(define-key 'z-map (kbd "u") 'elfeed-update)
(define-key 'z-map (kbd "s") 'bookmark-set)
(define-key 'z-map (kbd "j") 'bookmark-jump)
(define-key 'z-map (kbd "d") 'bookmark-delete)
(global-set-key (kbd "C-x e") 'elfeed) ;; open elfeed


;; protesilaos stuff https://protesilaos.com/codelog/2021-07-24-emacs-misc-custom-commands/ 
;;Xah file backup
(define-key 'z-map (kbd "b") 'xah-make-backup)
(defun xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is in this format
 x.html~2018-05-15_133429~
 The last part is hour, minutes, seconds.
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.

URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2018-05-15"
  (interactive)
  (let (($fname (buffer-file-name))
($date-time-format "%Y-%m-%d_%H%M%S"))
    (if $fname
(let (($backup-name
       (concat $fname "~" (format-time-string $date-time-format) "~")))
  (copy-file $fname $backup-name t)
  (message (concat "Backup saved at: " $backup-name)))
      (if (string-equal major-mode "dired-mode")
  (progn
    (mapc (lambda ($x)
    (let (($backup-name
   (concat $x "~" (format-time-string $date-time-format) "~")))
      (copy-file $x $backup-name t)))
  (dired-get-marked-files))
    (message "marked files backed up"))
(user-error "buffer not file nor dired")))))


(define-key 'z-map (kbd "n") 'prot-simple-rename-file-and-buffer)
;; A variant of this is present in the crux.el package by Bozhidar
;; Batsov.
;;;###autoload
(defun prot-simple-rename-file-and-buffer (name)
  "Apply NAME to current file and rename its buffer.
Do not try to make a new directory or anything fancy."
  (interactive
   (list (read-string "Rename current file: " (buffer-file-name))))
  (let ((file (buffer-file-name)))
    (if (vc-registered file)
        (vc-rename-file file name)
      (rename-file file name))
    (set-visited-file-name name t t)))

(define-key 'z-map (kbd "p") 'prot-diff-buffer-dwim)
(defun prot-diff-buffer-dwim (&optional arg)
  "Diff buffer with its file's last saved state, or run `vc-diff'.
With optional prefix ARG (\\[universal-argument]) enable
highlighting of word-wise changes (local to the current buffer)."
  (interactive "P")
  (let ((buf))
    (if (buffer-modified-p)
        (progn
          (diff-buffer-with-file (current-buffer))
          (setq buf "*Diff*"))
      (vc-diff)
      (setq buf "*vc-diff*"))
    (when arg
      (with-current-buffer (get-buffer buf)
        (unless diff-refine
          (setq-local diff-refine 'font-lock))))))

;; I copy this from `browse-url-button-regexp' simply because there are
;; contexts where we do not need that dependency.
(defvar prot-common-url-regexp
  (concat
   "\\b\\(\\(www\\.\\|\\(s?https?\\|ftp\\|file\\|gopher\\|gemini\\|jpg\\|"
   "nntp\\|news\\|telnet\\|wais\\|mailto\\|info\\):\\)"
   "\\(//[-a-z0-9_.]+:[0-9]*\\)?"
   (let ((chars "-a-z0-9_=#$@~%&*+\\/[:word:]")
	     (punct "!?:;.,"))
     (concat
      "\\(?:"
      ;; Match paired parentheses, e.g. in Wikipedia URLs:
      ;; http://thread.gmane.org/47B4E3B2.3050402@gmail.com
      "[" chars punct "]+" "(" "[" chars punct "]+" ")"
      "\\(?:" "[" chars punct "]+" "[" chars "]" "\\)?"
      "\\|"
      "[" chars punct "]+" "[" chars "]"
      "\\)"))
   "\\)")
  "Regular expression that matches URLs.
Copy of variable `browse-url-button-regexp'.")

(autoload 'goto-address-mode "goto-addr")

(define-key 'z-map (kbd "r") 'prot-search-occur-urls)
;;;###autoload
(defun prot-search-occur-urls ()
  "Produce buttonised list of all URLs in the current buffer."
  (interactive)
  (add-hook 'occur-hook #'goto-address-mode)
  (occur prot-common-url-regexp "\\&")
  (remove-hook 'occur-hook #'goto-address-mode))
;; Keybinds

;;(global-set-key (kbd "<s-up>") 'windmove-up)
;;(global-set-key (kbd "<s-down>") 'windmove-down)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
;;(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save) ;; copy
(global-set-key (kbd "C-y") 'clipboard-yank) ;; paste
(global-set-key (kbd "C-w") 'clipboard-kill-region) ;; cut
(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x t") 'erc-track-switch-buffer) ;; switch to next erc-buffer new message
(global-set-key (kbd "C-c <left>") 'winner-undo)
(global-set-key (kbd "C-c <right>") 'winner-redo)
(exwm-input-set-key (kbd "<s-left>") 'windmove-left)
(exwm-input-set-key (kbd "<s-right>") 'windmove-right)
(exwm-input-set-key (kbd "<s-up>") 'windmove-up)
(exwm-input-set-key (kbd "<s-down>") 'windmove-down)
(exwm-input-set-key (kbd "s-z") 'ido-switch-buffer)
;;(global-set-key (kbd "C-x w") 'ace-window)
(global-set-key (kbd "C-x f") 'exwm-floating-toggle-floating)
(global-set-key (kbd "C-M-x") 'eval-defun)

;;(define-key (current-global-map) (kbd "<insert>") 'other-window)
;;(global-set-key (kbd "<insert>") (lambda() 'other-window))
;;(set-face-attribute 'org-table nil
;;       :inherit: fixed-pitch))
;;(global-set-key (kbd "s") "s" #'ignore)
;;(global-set-key (kbd "s") 'self-insert-command)

;;(setq exwm-input-global-keys '((<insert> . other-window)))
;;(define-key global-map (kbd "<insert>") 'other-window)
;;(define-key global-map (kbd "<menu>") nil)
;;(exwm-input-set-key '(("<s-up>") . other-window)
;;(exwm-input-set-key (current-global-map) (kbd "<insert>") 'other-window);;you may have to restart exwm for it to take effect
;;(define-key (exwm-input-set-key) (kbd "<insert>") 'ace-window)
;;(setq exwm-input-global-keys '(("<s-down>" . windmove-down)))
;;(define-key exwm-mode-map '(("<menu>" . other-window)) nil)
;;(define-key exwm-mode-map '((<insert> . other-window)))
;;(define-key exwm-mode-map (kbd "C-c") nil) ;; completely disable mode-specific keys
;;(global-set-key (kbd "C-x w") 'ace-window)

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

;; Run Applications and commands

(defun bash-history()
  "Display All Bash History"
  (interactive)
  (completing-read "History" (with-temp-buffer (insert-file-contents "~/.bash_history") (split-string (buffer-string) "\n" t))))

(defun flameshot ()
  "Flameshot AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./Flameshot-0.10.1.x86_64.AppImage" nil 0))

(defun vieb ()
  "Vieb Browser AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./Vieb-5.3.0.AppImage" nil 0))

(defun lbry ()
  "LBRY AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./LBRY_0.51.1.AppImage" nil 0))

(defun qtox ()
  "qTox AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./qTox-v1.17.3.x86_64.AppImage" nil 0))

(defun status ()
  "Status AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./StatusIm-Desktop-v0.2.1-beta-1632af.AppImage" nil 0))

(defun tribler ()
  "Tribler"
  (interactive)
  (call-process-shell-command "/usr/bin/./tribler" nil 0))

(defun brave-browser ()
  "brave browser"
  (interactive)
  (call-process-shell-command "/usr/bin/./brave-browser-nightly" nil 0))

(defun luakit-browser ()
  "luakit browser"
  (interactive)
  (call-process-shell-command "/usr/bin/./luakit" nil 0))

(defun min-browser ()
  "min browser"
  (interactive)
  (call-process-shell-command "/usr/bin/./min" nil 0))

(defun xfce4-screenshooter ()
  "xfce4-screenshooter"
  (interactive)
  (call-process-shell-command "/usr/bin/./xfce4-screenshooter" nil 0))

(defun aether ()
  "Aether Reddit-like P2P"
  (interactive)
  (call-process-shell-command "/usr/bin/./AetherP2P" nil 0))

(defun xfce4-terminal ()
  "xfce4-terminal"
  (interactive)
  (call-process-shell-command "/usr/bin/./xfce4-terminal" nil 0))

(defun volumeicon ()
  "volumeicon"
  (interactive)
  (call-process-shell-command "/usr/bin/./volumeicon" nil 0))

(defun kitty-terminal ()
  "kitty-terminal"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./kitty" nil 0))

(defun nm-applet ()
  "nm-applet"
  (interactive)
  (call-process-shell-command "/usr/bin/./nm-applet" nil 0))

(defun twitch ()
  "Twitch AppImage"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-twitch-gui-v1.11.0-x86_64.AppImage" nil 0))

(defun caffeine-indicator ()
  "caffeine-indicator"
  (interactive)
  (call-process-shell-command "/usr/bin/caffeine-indicator" nil 0))

(defun Disks ()
  "Gnome-Disks Browser"
  (interactive)
  (call-process-shell-command "/usr/bin/./gnome-disks" nil 0))

(defun elza-browser ()
  "Elza Browser"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./ElzaBrowser.Setup.AppImage" nil 0))

(defun netsurf ()
  "NetSurf Browser"
  (interactive)
  (call-process-shell-command "/usr/bin/./netsurf" nil 0))

(defun qbittorrent ()
  "qBittorrent"
  (interactive)
  (call-process-shell-command "flatpak run org.qbittorrent.qBittorrent" nil 0))

(defun geary ()
  "Geary"
  (interactive)
  (call-process-shell-command "flatpak run org.gnome.Geary" nil 0))

(defun moonplayer ()
  "MoonPlayer"
  (interactive)
  (call-process-shell-command "flatpak run com.github.coslyk.MoonPlayer" nil 0))

(defun freetube ()
  "FreeTube"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./freetube_0.13.2_amd64.AppImage" nil 0))

(defun handbrake ()
  "HandBrake Encoder"
  (interactive)
  (call-process-shell-command "/usr/bin/handbrake" nil 0))

(defun xonotic ()
  "Xonotic Shooter Game"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/Xonotic/./xonotic-linux64-glx"))

;; Twitch Streams

(defun summit1g ()
  "Summit1G Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/summit1g 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun cdnthe3rd ()
  "CDNThe3rd Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/cdnthe3rd 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun sodapoppin ()
  "Sodapoppin Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/sodapoppin 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun pokelawls ()
  "Pokelawls Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/pokelawls 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun shroud ()
  "Shroud Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/shroud 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun valorant ()
  "Valorant Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/valorant 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun adeptthebest ()
  "Mari-Posa (adeptthebest) Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/adeptthebest 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun kyle ()
  "Kyle Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/kyle 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun timmac ()
  "Timmac Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/timmac 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun whippy ()
  "Whippy Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/whippy 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

(defun biotoxz_ ()
  "Biotoxz_ Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/biotoxz_ 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun xqc ()
  "xQc Twitch Stream"
  (interactive)
  (call-process-shell-command "/home/danrobi/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/xqcow 480p --stdout | /usr/bin/mpv /dev/stdin" nil 0))

;; Package List
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(emacs-emoji-cheat-sheet emoji-cheat-sheet-plus emojify auto-package-update ctrlf marginalia use-package exwm elpher elfeed)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
