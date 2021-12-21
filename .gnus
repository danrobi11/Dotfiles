(setq gnus-select-method '(nnimap "yahoo"
				  (nnimap-address "imap.mail.yahoo.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(open-gnutls-stream "tls" "tls-buffer" "imap.mail.yahoo.com" "imaps")
