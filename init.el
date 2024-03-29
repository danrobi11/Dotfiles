(add-variable-watcher 'the-var-to-be-watched
		      (lambda (sym new-value operation where)
			(message "Value for %s getting modified to %s with %s in buffer %s"
				 sym new-value operation where)))

;; (require 'package)
;; (add-to-list 'package-archives
;; 	     '("melpa" . "https://melpa.org/packages/")) ;;  (add-to-list approach preserves the default gnu elpa value in the list as well)
;; (package-refresh-contents)
;; (package-initialize)
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))

;; Set frame transparency
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))
;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name)) ;; required by exwm add-hook update-class

(use-package exwm ;; require xelb
  :ensure t
  :init
  (setq exwm-init t) ;; start exwm init 
  :config
  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class) ;; auto rename buffer with app name
  (require 'exwm-systemtray)
  (setq exwm-systemtray-height '18)
  (exwm-systemtray-enable))

;; (require 'exwm-randr)
;; (exwm-randr-enable)
;; (start-process-shell-command "xrandr" nil "1980x1080")
;; (defun efs/set-wallpaper ()
;;   (interactive)
;;   (start-process-shell-command
;;    "feh" nil  "feh --bg-scale /usr/share/backgrounds/desktop-background-girl.darked.png"))
;; (efs/set-wallpaper)

;;(setq exwm-randr-workspace-monitor-plist '(0 "eDP-1"
;;                                             1 "DP-1-1"
;;                                             2 "DP-1-3"))
;;  (add-hook 'exwm-randr-screen-change-hook
;;            (lambda ()
;;              (start-process-shell-command
;;               "xrandr" nil "xrandr --output DP-1-3 --right-of eDP-1 --output DP-1-1 --left-of eDP-1")))
;;  # 1920x1080 @ 60.00 Hz (GTF) hsync: 67.08 kHz; pclk: 172.80 MHz
;;  Modeline "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync


;; Elfeed is a web feed client for Emacs
(use-package elfeed
  :ensure t
  :config
  (load (expand-file-name "~/.elfeed/elfeed.el"))
  (setq-default elfeed-search-filter "@1-week-ago +unread ")
  (setq-default elfeed-search-title-max-width '145)
  (defun elfeed-mark-all-as-read ()
    "Mark all unread feeds as read"
    (interactive)
    (elfeed-untag 'elfeed-search-entries 'unread)
    (elfeed-search-update :force))) ; redraw

(use-package erc
  :ensure t
  :config
  (load (expand-file-name "~/.emacs.d/.ercrc.el"))
  (erc-notify-mode) ;; notification in mode-line
  (erc-notifications-mode) ;; desktop notification
  (setq erc-hide-list '("JOIN" "PART" "QUIT"))
  (setq erc-fill-column '200)
  (setq erc-fill-static-center 27) ;; need to test this
  (setq-default erc-default-server "irc.libera.chat")
  ;;  (setq erc-header-line '0)
  (erc-fill-mode)
  (global-set-key (kbd "C-x t") 'erc-track-switch-buffer))

(use-package elpher
  :ensure t
  :config
  (setq elpher-use-tls 't)
  (setq elpher-gemini-max-fill-width '200))
(setq gnutls-verify-error 't)

;;; Server Setup
(use-package server
  :ensure nil
  :defer 1
  :config
  (unless (server-running-p)
    (server-start)))

(setenv "EDITOR" "emacsclient")

;; (use-package selectrum
;;   :ensure t
;;   :init)
;;  (selectrum-mode))

;;(use-package counsel
;;  :ensure t
;;  :init
;;  (counsel-mode))

;;(use-package ace-window
;;  :ensure t
;;  :init)
;;  :bind (("<insert>" . ace-window)))

;; (use-package emoji-cheat-sheet-plus
;;   :ensure t
;;   :init)

;;(use-package which-key
;;  :ensure t
;;  :init)

;; (use-package emojify
;;   :ensure t
;;   :init
;;   :config
;;   (global-emojify-mode))

;; (use-package dired-toggle-sudo
;;   :ensure t
;;   ;; :init
;;   ;; (eval-after-load 'tramp
;;   ;;   '(progn
;;   ;;      ;;/sudo:user@host:/usr/
;;   ;;      (add-to-list 'tramp-default-proxies-alist
;;   ;; 		    '(".*" "\\`.+\\'" "/ssh:%h:"))))
;;   :bind (("C-c C-s" . dired-toggle-sudo)))

(use-package ctrlf ;; https://github.com/raxod502/ctrlf
  :ensure t
  :init
  :config
  (ctrlf-mode))

(use-package marginalia ;;  
  :ensure t
  :init
  :config
  (marginalia-mode))

;; (use-package icomplete-vertical
;;   :ensure t
;;   :demand t
;;   :custom
;;   (read-file-name-completion-ignore-case t)
;;   (read-buffer-completion-ignore-case t)
;;   (completion-ignore-case t)
;;   :config
;;   (fido-mode)
;;   (icomplete-vertical-mode)
;; (setq icomplete-vertical-prospects-height '10)

(use-package auto-package-update
  :ensure t)

;; (use-package sudo-edit
;;   :ensure t )

(use-package aggressive-indent ;; keep your code nicely aligned
  :ensure t
  :init
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (global-aggressive-indent-mode))

;; (use-package helm
;;   :ensure t
;;   :config
;;   (setq helm-buffer-max-length '40)) ;; helm-buffers-list max length
;;  (helm-mode))

;; (use-package ytdl
;;   :ensure t
;;   :config
;;   (setq ytdl-command "/usr/bin/yt-dlp")
;;   (setq ytdl-download-extra-args '("--format" "18"))
;;   (setq ytdl-video-folder "/home/danrobi/Videos-Youtube-Downloads")
;;   (setq ytdl-title-column-width '90)
;;   (setq ytdl-always-query-default-filename t))
;; query default filenme from teh web server, without confirmation
;;  :bind (("C-x y" . ytdl-download))) ;; working**


;; Hide the dotfile in dired. Hiden files
(use-package dired-hide-dotfiles
  :ensure t)

;; my-dired-mode-hook
(defun my-dired-mode-hook ()
  "My `dired' mode hook."
  ;; To hide dot-files by default
  (dired-hide-dotfiles-mode))

;; To toggle hiding
(define-key dired-mode-map "." #'dired-hide-dotfiles-mode)
(add-hook 'dired-mode-hook #'my-dired-mode-hook)
;; End of my-dired-mode-hook

;; Epithet
;; Rename eww buffer to title
(add-to-list 'load-path "/home/danrobi/.emacs.d/epithet")
(require 'epithet)
(add-hook 'eww-after-render-hook #'epithet-rename-buffer)
;; end of epithet

;; symon
;; display cpu and memory usage in the mini-buffer
;; (add-to-list 'load-path "/home/danrobi/.emacs.d/symon")
;; (require 'symon)
;; (setq symon-sparkline-type 'plain)
;; (setq symon-sparkline-thickness '1)
;; (setq symon-sparkline-width '1)
;; (symon-mode 1)
;; end of symon

;; awesome-tray
;; display mode-line in the mini-buffer
;; (add-to-list 'load-path "/home/danrobi/.emacs.d/awesome-tray")
;; (setq awesome-tray-buffer-name-max-length '100)
;; (require 'awesome-tray)
;; (awesome-tray-mode 1)

;;(videos-Youtube-Downloadsuse-package amx ;; require ido-completing-read+
;;  :ensure t
;;  :init
;;  :config)
;;  (amx-mode 1))

;;(use-package ido-completing-read+
;;  :ensure t
;;  :init)


;; gnus stuff
(setq message-send-mail-function 'smtpmail-send-it) ; if you use message/Gnus
;; required for gnus rss feed
;; (require 'mm-url)
;; (defadvice mm-url-insert (after DE-convert-atom-to-rss () )
;;   "Converts atom to RSS by calling xsltproc."
;;   (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\"" 
;; 			   nil t)
;;     (goto-char (point-min))
;;     (message "Converting Atom to RSS... ")
;;     (call-process-region (point-min) (point-max) 
;; 			 "xsltproc" 
;; 			 t t nil 
;; 			 (expand-file-name "~/atom2rss.xsl") "-")
;;     (goto-char (point-min))
;;     (message "Converting Atom to RSS... done")))
;;(ad-activate 'mm-url-insert)

;; Emacs Customization
;;(face-spec-set 'vertical-border-face '((t :background black)))
;;(setq fringe-styles '("no-fringes" . 0))
;;(setq 'fringe-styles '("no-fringes" . 0))
(delete-selection-mode 1) ;; typed text replaces the selection if the selection is active.
;;(server-start)
;;(face-spec-set 'vertical-border '((t :inherit modeline)))
(winner-mode 1)
(fringe-mode 0)
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
(ido-mode 1) ;; https://www.gnu.org/software/emacs/manual/html_mono/ido.html
;;(ido-everywhere 1) ;; more ido stuff https://masteringemacs.org/article/introduction-to-ido-mode
(setq line-move-visual 'nil) ;; move up/down line with softwrap
(setq ido-separator "\t") ;; display ido buffer vertically
(setq icomplete-separator "\t") ;; display icomplete/fido vertically or with https://github.com/oantolin/icomplete-vertical
(setq resize-mini-windows 'nil)
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)
(blink-cursor-mode -1)
(save-place-mode 1) ;; save where cursor is in buffers
(auto-save-mode 1)
(auto-save-visited-mode 0) ;; autosave new edited buffers
(tool-bar-mode 0)
(display-time-mode 1)
(line-number-mode -1)
(scroll-bar-mode -1)
(auto-fill-mode 1) ;; automatically breaks the line
(global-eldoc-mode 1)
(global-reveal-mode 1)
(which-function-mode 1)
(global-highlight-changes-mode 1)
;; automatically rotate colors when the buffer is saved
(add-hook 'write-file-functions 'highlight-changes-rotate-faces nil t)
;;(helm-adaptive-mode 1)
(recentf-mode 1) ;; display recently opened file from `find-file` "C-x C-f"
(setq recentf-auto-cleanup nil)
(setq recentf-auto-cleanup 'never)
(icomplete-mode 0)
(fido-mode 1) ;; replacement for icomplete-mode
(menu-bar-mode -1)
(pixel-scroll-mode -1)
(global-auto-revert-mode 1)
;;(line-number-mode "") ;; display current line number in the mode-line
;;(format-mode-line "%l")
(display-battery-mode 0) ;; display battery charge level
(setq dired-listing-switches "-alh") ;; dired file size in mb
;;(setq display-time-day-and-date 0)
;; (setq display-time-default-load-average "\t")
;; (setq mode-line-in-non-selected-windows "\t")
;;(setenv "EDITOR" "emacsclient")
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; mouse scroll one line at a time
(setq scroll-conservatively '1) ;; keyboard scroll one line at the time
(setq shr-inhibit-images '0) ;; disable displaying images in eww and elfeed
(setq fill-region 'center)
;;(setq async-shell-command-buffer 'new-buffer)
(setq url-privacy-level 'paranoid) ;; eww don’t send anything
(setq exwm-manage-force-tiling 't) ;; prevent apps to launch in floating buffer
(setq max-mini-window-height '100)

;; disable the async-shell-command popup buffer
(add-to-list 'display-buffer-alist
	     (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

;; ibuffer display name only
(setq ibuffer-formats '((mark " " name)
			(mark modified read-only
			      (name 16 16 :left)
			      (size 6 -1 :right))))

;;(ace-window-display-mode 1) ;; ace-window buffer number in the modeline
;;(setq aw-display-mode-overlay nil) ;; ace-window buffer number in the overlay
;;(setq aw-background nil) ;; ace-window overlay on/off

;; Open url link with eww
;;(setq browse-url-browser-function 'eww-browse-url)
;; (defun Junction ()
;;   "Junction Open-With"
;;   (interactive)
;;   (call-process-shell-command "flatpak run re.sonny.Junction" nil 0)) ;;
;; Run this program and use `xdg-open
;; https://github.com/sonnyp/Junction
(setq browse-url-browser-function 'browse-url-firefox) ;; #'browse-url-firefox
(setq browse-url-firefox-program "xdg-open")
;; other browser setup
;;(setq browse-url-browser-function 'browse-url-firefox) ;; #'browse-url-firefox
;;(setq browse-url-firefox-program "netsurf")
;;(setq browse-url-browser-function 'browse-url-default-browser)
;;dbus-send --type=method_call --dest=org.netsurf_browser.NetSurf

;; Backgrounds
(defun snow-background ()
  "Snow Theme"
  (interactive)
  (set-face-background #'mode-line-inactive "snow")
  (set-face-foreground #'mode-line-inactive "black")
  (set-face-background #'mode-line "gray")
  (set-face-foreground #'mode-line "black")
  (set-background-color "snow")
  (set-foreground-color "black")
  (set-face-background 'elfeed-search-title-face "snow")
  (set-face-foreground 'elfeed-search-title-face "red")
  (set-face-background 'elfeed-search-unread-title-face "snow")
  (set-face-foreground 'elfeed-search-unread-title-face "purple")
  (set-face-attribute 'region nil :background "gray"))

(defun lightsteelblue4-background ()
  "LightSteelBlue4 Theme"
  (interactive)
  (set-face-background #'mode-line-inactive "LightSteelBlue4")
  (set-face-foreground #'mode-line-inactive "gray")
  (set-face-background #'mode-line "black")
  (set-face-foreground #'mode-line "gray")
  (set-background-color "LightSteelBlue4")
  (set-foreground-color "black")
  (set-face-background 'elfeed-search-title-face "snow")
  (set-face-foreground 'elfeed-search-title-face "black")
  (set-face-background 'elfeed-search-unread-title-face "black")
  (set-face-foreground 'elfeed-search-unread-title-face "purple")
  (set-face-attribute 'region nil :background "snow"))

(defun black-background ()
  "Black Theme"
  (interactive)
  (set-face-background #'mode-line-inactive "black")
  (set-face-foreground #'mode-line-inactive "snow")
  (set-face-background #'mode-line "purple") ;; SlateBlue4
  (set-face-foreground #'mode-line "black")
  (set-background-color "black")
  (set-foreground-color "purple")
  (set-face-background 'elfeed-search-title-face "black")
  (set-face-foreground 'elfeed-search-title-face "red")
  (set-face-background 'elfeed-search-unread-title-face "black")
  (set-face-foreground 'elfeed-search-unread-title-face "purple")
  (set-face-foreground 'elfeed-search-feed-face "#77a")
  (set-face-background hl-line-face "snow")
  (set-cursor-color "LightSteelBlue4")
  (set-face-attribute 'region nil :background "LightSteelBlue4"))

;; (:background "blue-violet" :foreground "snow" :box "0" :weight "ultra-light" :height "0.9"))

;; set env path
(setq exec-path '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/share" "/var/lib/" "~/" "~/.local/bin" "~/.guix-profile" "/etc/profile" "/gnu/store/16lzrmanm6x04ziqywv94p5xxfziljpx-flatpak-1.10.2/bin"))

;; protesilaos stuff
;; https://protesilaos.com/codelog/2021-07-24-emacs-misc-custom-commands/ 
;;Xah file backup
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

;; required by prot-search-occur-urls
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
 ;;;###autoload
(defun prot-search-occur-urls ()
  "Produce buttonised list of all URLs in the current buffer."
  (interactive)
  (add-hook 'occur-hook #'goto-address-mode)
  (occur prot-common-url-regexp "\\&")
  (remove-hook 'occur-hook #'goto-address-mode))
;; end of prot stuff

;; clean-exit show unsaved file in list when closing emacs
;; https://old.reddit.com/r/emacs/comments/p04680/list_unsaved_buffers_before_exiting_emacs/
(defun clean-exit ()
  "Exit Emacs cleanly.
 If there are unsaved buffer, pop up a list for them to be saved
 before existing. Replaces ‘save-buffers-kill-terminal’."
  (interactive)
  (if (frame-parameter nil 'client)
      (server-save-buffers-kill-terminal arg)
    (if-let ((buf-list (seq-filter (lambda (buf)
				     (and (buffer-modified-p buf)
					  (buffer-file-name buf)))
				   (buffer-list))))
	(progn
	  (pop-to-buffer (list-buffers-noselect t buf-list))
	  (message "s to save, C-k to kill, x to execute"))
      (save-buffers-kill-emacs))))

;; crux-extensions stuff
;; https://github.com/bbatsov/crux/blob/master/crux.el
(defun crux-delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
	  (vc-delete-file filename)
	(when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
	  (delete-file filename delete-by-moving-to-trash)
	  (message "Deleted file %s" filename)
	  (kill-buffer))))))

(defalias 'crux-delete-buffer-and-file #'crux-delete-file-and-buffer)

(defun insert-date-and-time ()
  "Insert a timestamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

(defun create-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))
;; end of the crux stuff

;; copy the whole line
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
		  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; end of copy whole line

;; oantolin stuff
;; Open file externally with the system's default application
;; https://old.reddit.com/r/emacs/comments/paqvav/how_to_open_different_types_of_file_with_one/
(defun open-file-externally (file)
  (interactive)
  "Open FILE externally"
  (call-process (pcase system-type
		  (_ "xdg-open"))
		nil 0 nil
		(expand-file-name file)))

(defun dired-open-externally (&optional arg)
  "Open marked or current file in operating system's default application."
  (interactive "P")
  (dired-map-over-marks
   (open-file-externally (dired-get-filename))
   arg))
;; end of the oantolin stuff

;; Pennersr Proctrack-mode ;; change shell buffer name
;; https://gitlab.com/pennersr/proctrack-mode

(make-variable-buffer-local
 (defvar proctrack-timer nil
   "TODO"))


(defun proctrack-child-process (pid)
  (let ((cpids (--filter (eq pid (cdr (assoc 'ppid (process-attributes it))))
			 (list-system-processes))))
    (if cpids (car cpids) pid)))


(defun proctrack-get-name (buffer)
  (let ((proc (get-buffer-process (buffer-name buffer))))
    (format "*%s*" (if proc (cdr (assoc 'args (process-attributes (proctrack-child-process
								   (process-id proc)))))
		     "unknown"))))

(defun proctrack-on-timer (buffer)
  (if (buffer-live-p buffer)
      (with-current-buffer buffer (rename-buffer (proctrack-get-name buffer) t))
    (when proctrack-timer (cancel-timer proctrack-timer)) ))


(defun proctrack-cancel-timer ()
  (when proctrack-timer (cancel-timer proctrack-timer))
  (setq proctrack-timer nil))

(defun proctrack-enable ()
  (let* (;; Should have just been this:
	 ;;  (setq proctrack-timer  (run-with-idle-timer 1 t 'proctrack-on-timer (current-buffer) ))
	 ;; Due to...
	 ;;     https://debbugs.gnu.org/cgi/bugreport.cgi?bug=51589
	 ;; ... term-mode-hooks get excuted twice, meaning, our `proctrack-enable` gets
	 ;; executed twice and so far I cannot find a proper way to stop the duped timers...
	 (buffer (current-buffer))
	 (fns (make-symbol "local-idle-timer"))
	 (timer (run-with-idle-timer 1 t fns buffer ))
	 (fn `(lambda (buffer)
		(if (not (buffer-live-p buffer))
		    (cancel-timer ,timer)
		  (proctrack-on-timer buffer)))))
    (fset fns fn))
  (add-hook 'kill-buffer-hook 'proctrack-cancel-timer))


(defun proctrack-disable ()
  (proctrack-cancel-timer))


(define-minor-mode proctrack-mode "TODO"
  :lighter " ptrk"
  :init-value nil
  (if proctrack-mode (proctrack-enable)
    (proctrack-disable))) 
;; 
;; End of Pennersr Proctrack-Mode

;; shell-instead-dired
;; Open the Dired current Directory In Shell Term
(defun shell-instead-dired ()
  (interactive)
  (let ((dired-buffer (current-buffer)))
    (shell (concat default-directory "-shell"))))
;; End of shell-instead-dired

(defun crux-create-scratch-buffer ()
  "Create a new scratch buffer."
  (interactive)
  (let ((buf (generate-new-buffer "*scratch*")))
    (switch-to-buffer buf)
    (funcall initial-major-mode)))

;; my-yank-pop ;; This works without selectrum and ido
;; replace the default yank-pop. It lets you choose in the kill-ring
;; https://github.com/raxod502/selectrum/wiki/Useful-Commands#my-yank-pop
;; Ref: https://www.gnu.org/software/emacs/manual/html_node/eintr/yank.html
(defun my-yank-pop (&optional arg)
  "Paste a previously killed string.
 With just \\[universal-argument] as ARG, put point at beginning,
 and mark at end.  Otherwise, put point at the end, and mark at
 the beginning without activating it.
 
 This is like `yank-pop'.  The differences are:
 
 - This let you manually choose a candidate to paste.
 
 - This doesn't delete the text just pasted if the previous
   command is `yank'."
  (interactive "P")
  (let* ((selectrum-should-sort nil)
	 (text nil))
    (setq text
	  (completing-read "Yank: "
			   (cl-remove-duplicates
			    kill-ring :test #'equal :from-end t)
			   nil 'require-match))
    (unless (eq last-command 'yank)
      (push-mark))
    (setq last-command 'yank)
    (setq yank-window-start (window-start))
    (when (and delete-selection-mode (use-region-p))
      (delete-region (region-beginning) (region-end)))
    (insert-for-yank text)
    (if (consp arg)
	(goto-char (prog1 (mark t)
		     (set-marker (mark-marker) (point) (current-buffer)))))))
;; end of my-yank-pop

;; recentf-open-files+
;; open recentf file with selectrum or ido.
(defun recentf-open-files+ ()
  "Use `completing-read' to open a recent file."
  (interactive)
  (let ((files (mapcar 'abbreviate-file-name recentf-list)))
    (find-file (completing-read "Find recent file: " files nil t))))
;; end of recentf-open-files+
(defface egoge-display-time
  '((((type x w32 mac))
     ;; #060525 is the background colour of my default face.
     (:foreground "#060525" :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

;; My mode-line config
;; Display CPU/MEM usage in the mode line
(defun cpu-memory-usage ()
  "Display CPU/MEM Usage"
  (shell-command-to-string "ps -A -o pcpu | tail -n+2 | paste -sd+ | bc | tr -cd '\40-\176' && echo ' '| tr -cd '\40-\176' && free -t --mega | grep Mem | awk '{print $1,$7}' | tr -cd '\40-\176'"))

;; (setq mode-line-end-spaces
;;       (list
;;        (propertize "Cpu: " 'face 'bold)
;;        '(:eval (propertize (cpu-memory-usage-3) 'face 'bold))
;;        " "))

;; (defun my-mode-line/padding ()
;;   (let ((r-length (length (format-mode-line mode-line-end-spaces))))
;;     (propertize " "
;; 		'display `(space :align-to (- right ,r-length)))))

(setq-default mode-line-format
	      (list
	       " %+ "
	       (propertize "%b " 'face 'bold)
	       "- "
	       "%o "
	       "- "
	       "[Mode:%m] - "
	       '(:eval (propertize (format-time-string "%a %b/%d/%Y %H:%M") 'face 'bold))
	       " - "
	       (propertize "Cpu: " 'face 'bold)
	       '(:eval (propertize (cpu-memory-usage) 'face 'bold))))
;; mode-line-end-spaces))
;; End of Display CPU/MEM usage in the mode line

;;(force-mode-line-update 'all)))
;; %D %R other best
;;	       '(:eval (cpu-memory-usage)))))
;; %a %b | %Y-%m-%d_%H%M%S | %b/%d/%Y %H:%M
;;	       '(:eval (count-lines-page))))
;; (setq display-time-string-forms
;; 	    '((propertize (concat " " 24-hours ":" minutes " ")
;; 			  'face 'egoge-display-time)))
;;(display-time-format "%b/%d/%Y %H:%M"))) ;; format-time-string
;; (face-spec-set 'mode-line-inactive '((t :inherit modeline)))
;; (face-spec-set 'mode-line-inactive '((t (:box))))
;; (face-spec-set 'mode-line '((t (:box))))
;;end of my mode-line config


;; Download Youtube Videos
(defun mpv-youtube-360p (M-Y-360)
  "Mpv Youtube 360p"
  (interactive "sPaste YouTube URL: ")
  (start-process-shell-command "mpv" nil "mpv --ytdl-format=18" nil "%s" M-Y-360))

(defun youtube-download (Y-URL)
  "Download Youtube Video"
  (interactive "sPaste YouTube URL: ")
  (start-process-shell-command "yt-dlp" nil "yt-dlp -P~/Videos-Youtube-Downloads" nil "%s" Y-URL))

(defun youtube-download-360p (Y-URL-360)
  "Download Youtube Video"
  (interactive "sPaste YouTube URL: ")
  (start-process-shell-command "yt-dlp" nil "yt-dlp -f18 -P~/Videos-Youtube-Downloads" nil "%s" Y-URL-360))
;; End Of Download Youtube Videos

;; Make *shell* buffer open in current buffer
(add-to-list 'display-buffer-alist '("\\*shell\\*" (display-buffer-same-window)) t)

;; Keybinds
;; Personal Prefix-Command (kbd "C-z")
(define-prefix-command 'z-map)
(exwm-input-set-key (kbd "C-z") 'z-map)
(define-key 'z-map (kbd "u") 'elfeed-update)
(define-key 'z-map (kbd "s") 'bookmark-set)
(define-key 'z-map (kbd "j") 'bookmark-jump)
(define-key 'z-map (kbd "d") 'bookmark-delete)
(define-key 'z-map (kbd "b") 'xah-make-backup)
(define-key 'z-map (kbd "n") 'prot-simple-rename-file-and-buffer)
(define-key 'z-map (kbd "r") 'prot-search-occur-urls)
(define-key 'z-map (kbd "p") 'prot-diff-buffer-dwim) ;; show new edited stuff in the file (before saving)
(define-key 'z-map (kbd "R") 'replace-regexp)
;;(define-key 'z-map (kbd "m") 'memory-usage)
(define-key 'z-map (kbd "m") 'mpv-youtube-360p)
;;(define-key 'z-map (kbd "c") 'cpu-memory-usage)
(define-key 'z-map (kbd "Y") 'youtube-download)
(define-key 'z-map (kbd "f") 'menu-find-file-existing)
(define-key 'z-map (kbd "w") 'wdired-change-to-wdired-mode)

(bind-keys*
 ("C-z y" . youtube-download-360p))

;;(global-set-key (kbd "<s-up>") 'windmove-up)
;;(global-set-key (kbd "<s-down>") 'windmove-down)
;;(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'clean-exit)
;;(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save) ;; selectrum or clipboard-kill-ring-save -ring-saveYYY-ring-save
(global-set-key (kbd "C-y") 'clipboard-yank) ;; paste
(global-set-key (kbd "C-w") 'clipboard-kill-region) ;; cut
;;(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-x") 'execute-extended-command)
;;(global-set-key (kbd "M-x") 'execute-extended-command)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "M-y") 'my-yank-pop)
;;(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x x") 'kill-this-buffer)
(global-set-key (kbd "C-x b") 'buffer-menu)
(global-set-key (kbd "C-x t") 'erc-track-switch-buffer) ;; switch to next erc-buffer new message
(global-set-key (kbd "C-c <left>") 'winner-undo)
(global-set-key (kbd "C-c <right>") 'winner-redo)
(exwm-input-set-key (kbd "<s-left>") 'windmove-left)
(exwm-input-set-key (kbd "<s-right>") 'windmove-right)
(exwm-input-set-key (kbd "<s-up>") 'windmove-up)
(exwm-input-set-key (kbd "<s-down>") 'windmove-down)
;;(exwm-input-set-key (kbd "s-z") 'ido-switch-buffer)
(exwm-input-set-key (kbd "s-z") 'switch-to-buffer) ;; ibuffer, ido-switch-buffer
;;(exwm-input-set-key (kbd "s-z") 'helm-buffers-list)
;;(global-set-key (kbd "C-x w") 'ace-window)
(global-set-key (kbd "C-x f") 'exwm-floating-toggle-floating)
(global-set-key (kbd "C-M-x") 'eval-defun)
(global-set-key (kbd "C-x e") 'elfeed) ;; open elfeed
(global-set-key (kbd "<f9>") 'dired-open-externally) ;; oantolin stuff
(global-set-key (kbd "<M-esc esc>") 'keyboard-escape-quit)
;;(define-key (current-global-map) (kbd "<insert>") 'other-window)
;;(keyboard-escape-quitglobal-set-key (kbd "<insert>") (lambda() 'other-window))
;;(set-face-attribute 'org-table nil
;;       :inherit: fixed-pitch))
;;(global-set-key (kbd "s") "s" #'ignore)
;;(global-set-key (kbd "s") 'self-insert-command)

(global-set-key (kbd "C-x <f5>") (lambda() (interactive)(load-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-x <f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-x <f7>") (lambda() (interactive)(find-file "~/")))
(global-set-key (kbd "C-x <f8>") (lambda() (interactive)(find-file "/media/danrobi/1tbstorage")))
(global-set-key (kbd "C-x /") (lambda() (interactive)(find-file "/home/danrobi/.emacs.d/emacs_keybind.txt")))

;; Aliases
(defalias 'oeh 'org-html-export-to-html)
(defalias 'ttl 'toggle-truncate-lines)
(defalias 'asc 'async-shell-command)
(defalias 'rb 'rename-buffer)
(defalias 'otld 'org-toggle-link-display)

;; Applications and Functions

;; (defun display-keybind-list ()
;;   "Display keybinds list"
;;   (interactive)
;;   (call-process-shell-command "~/.local/bin/./emacs_keybind.sh" nil 0))
;; (global-set-key (kbd "C-x /") 'display-keybind-list)

(defun bash-history ()
  "Display All Bash History"
  (interactive)
  (completing-read "History" (with-temp-buffer (insert-file-contents "~/.bash_history") (split-string (buffer-string) "\n" t))))

(defun appimagepool ()
  "AppImagePool Store"
  (interactive)
  (call-process-shell-command "~/.local/bin/./appimagepool-x86_64.AppImage" nil 0))

(defun flameshot ()
  "Flameshot AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./Flameshot-0.10.1.x86_64.AppImage" nil 0))

(defun dunst ()
  "Launch Dunst"
  (interactive)
  (call-process-shell-command "/usr/bin/dunst" nil 0))

(defun vieb ()
  "Vieb Browser AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./Vieb-6.2.0.AppImage" nil 0))

(defun lbry ()
  "LBRY AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./LBRY_0.51.2.AppImage" nil 0))

(defun qtox ()
  "qTox AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./qTox-v1.17.3.x86_64.AppImage" nil 0))

(defun status ()
  "Status AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./StatusIm-Desktop-v0.2.1-beta-1632af.AppImage" nil 0))

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
  (call-process-shell-command "volumeicon" nil 0))

(defun unclutter ()
  "Hide Mouse Cursor"
  (interactive)
  (call-process-shell-command "/usr/bin/./unclutter" nil 0))

(defun kitty-terminal ()
  "kitty-terminal"
  (interactive)
  (call-process-shell-command "/usr/bin/./kitty" nil 0))

(defun nm-applet ()
  "nm-applet"
  (interactive)
  (call-process-shell-command "nm-applet" nil 0))

(defun twitch ()
  "Twitch AppImage"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-twitch-gui-v1.13.0-x86_64.AppImage" nil 0))

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
  (call-process-shell-command
   "~/.local/bin/./ElzaBrowser.Setup.AppImage" nil 0))

(defun muwire ()
  "MuWire File-Sharing"
  (interactive)
  (call-process-shell-command "~/.local/bin/./MuWire-0.8.10.AppImage" nil 0))

(defun flatseal ()
  "Flatseal Flatpak Manager"
  (interactive)
  (call-process-shell-command "flatpak run com.github.tchx84.Flatseal" nil 0))

(defun netsurf ()
  "NetSurf Browser"
  (interactive)
  (call-process-shell-command "flatpak run org.netsurf_browser.NetSurf" nil 0))

(defun firefox ()
  "Firefox"
  (interactive)
  (call-process-shell-command "/usr/bin/firefox" nil 0))

(defun palemoon ()
  "Palemoon"
  (interactive)
  (call-process-shell-command "~/.local/bin/palemoon/palemoon" nil 0))

(defun qbittorrent ()
  "qBittorrent"
  (interactive)
  (call-process-shell-command "/usr/bin/qbittorrent" nil 0))

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
  (call-process-shell-command "~/.local/bin/./freetube_0.15.1_amd64.AppImage" nil 0))

(defun handbrake ()
  "HandBrake Encoder"
  (interactive)
  (call-process-shell-command "flatpak run fr.handbrake.ghb" nil 0))

(defun nyxt ()
  "Nyxt Browser"
  (interactive)
  (call-process-shell-command "/usr/bin/nyxt" nil 0)) ;; "/gnu/store/b4dmv2an5fhf5q8hx8j8clgf4i45vqnv-nyxt-2.1.1/bin/./nyxt"

(defun epiphany ()
  "Gnome Web"
  (interactive)
  (call-process-shell-command "flatpak run org.gnome.Epiphany" nil 0)) ;; /gnu/store/ashpf9q7hqmdwxzcv20na5jwry2w99na-epiphany-3.34.4/bin/./epiphany

(defun xonotic ()
  "Xonotic Shooter Game"
  (interactive)
  (call-process-shell-command "~/.local/bin/Xonotic/./xonotic-linux64-glx" nil 0))

(defun startup-emacs ()
  "Start Emacs With Dunst, Unclutter, Xrandr And Xset"
  (interactive)
  (call-process-shell-command "~/.local/bin/./startup-emacs" nil 0)) ;; && xset 'm 0 0' && xset '-dpms' && xrandr '--output HDMI-0 --mode 1920x1080'" nil 0))

(defun app-outlet ()
  "AppImage Store"
  (interactive)
  (call-process-shell-command "~/.local/bin/./App.Outlet-2.0.2.AppImage" nil 0))

(defun supertux ()
  "SuperTux Game"
  (interactive)
  (call-process-shell-command "~/.local/bin/./SuperTux-v0.6.3.glibc2.29-x86_64.AppImage" nil 0))

(defun librewolf ()
  "LibreWolf Browser"
  (interactive)
  (call-process-shell-command "~/.local/bin/./LibreWolf.x86_64.AppImage" nil 0))

;; Twitch Streams

(defun summit1g ()
  "Summit1G Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-2.3.0-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/summit1g 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun cdnthe3rd ()
  "CDNThe3rd Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/cdnthe3rd 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun sodapoppin ()
  "Sodapoppin Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/sodapoppin 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun pokelawls ()
  "Pokelawls Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/pokelawls 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun shroud ()
  "Shroud Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/shroud 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun valorant ()
  "Valorant Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/valorant 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun adeptthebest ()
  "Mari-Posa (adeptthebest) Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/adeptthebest 480p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun kyle ()
  "Kyle Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.3-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/kyle 360p --stdout | flatpak run io.mpv.Mpv /dev/stdin" nil 0))

(defun timmac ()
  "Timmac Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/timmac 480p --stdout | ~/.local/bin/SMPlayer-21.10.0-x86_64.AppImage /dev/stdin" nil 0))

(defun whippy ()
  "Whippy Twitch Stream"
  (interactive)
  (call-process-shell-command "flatpak run io.mpv.Mpv --ytdl-format=360p https://www.twitch.tv/whippy" nil 0))

(defun biotoxz_ ()
  "Biotoxz_ Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.2-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/biotoxz_ 360p --stdout | mpv /dev/stdin" nil 0))

(defun xqc ()
  "xQc Twitch Stream"
  (interactive)
  (call-process-shell-command "~/.local/bin/./streamlink-3.0.3-1-cp39-cp39-manylinux2014_x86_64.AppImage https://www.twitch.tv/xqcow 360p --stdout | mpv /dev/stdin" nil 0))

;; Package List
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters
   '(("programming"
      (or
       (derived-mode . prog-mode)
       (mode . ess-mode)
       (mode . compilation-mode)))
     ("text document"
      (and
       (derived-mode . text-mode)
       (not
	(starred-name))))
     ("TeX"
      (or
       (derived-mode . tex-mode)
       (mode . latex-mode)
       (mode . context-mode)
       (mode . ams-tex-mode)
       (mode . bibtex-mode)))
     ("web"
      (or
       (derived-mode . sgml-mode)
       (derived-mode . css-mode)
       (mode . javascript-mode)
       (mode . js2-mode)
       (mode . scss-mode)
       (derived-mode . haml-mode)
       (mode . sass-mode)))
     ("gnus"
      (or
       (mode . message-mode)
       (mode . mail-mode)
       (mode . gnus-group-mode)
       (mode . gnus-summary-mode)
       (mode . gnus-article-mode)))))
 '(package-selected-packages
   '(marginalia dired-hide-dotfiles aggressive-indent auto-package-update ctrlf use-package exwm elfeed)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
