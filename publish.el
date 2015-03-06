;;; publish.el --- Copy a buffer to a sshfs mounted folder somewhere
;; Copyright (C) 2011 Free Software Foundation, Inc.
;; Author Jimmy Arogén
;; version 0.11
;; keywords: publish, sshfs
;; URL: https://github.com/skitapa/publish.el
;;; Code:
;;; Commentary:
;; This package helps copy a buffer to a designated place somewhere. This can be used
;; to publish files if that folder is mounted with sshfs.

(defun publish ()
  "Save file to remotely mounted directory for publishing.
It will blatantly overwrite files with same filename in
that directory"
  (interactive)
  (setq save_point (point))
  (setq publish_dir "/Users/johndoe/testserver") ;; Set your publishing dir here without trailing slash
  (if (file-exists-p "/Users/johndoe/testserver/private/index.php") ;; checks if mounted, place file there or use available
      (progn
	(progn
	  (mark-whole-buffer)
	  (write-region nil (point-max)
			(concat publish_dir (substring (buffer-file-name) 29))))
	(deactivate-mark)
	(goto-char save_point))
    (progn
      (if (y-or-n-p "Server directory not mounted.  Mount it? ")
	  (progn
	    (start-process "pub_mount" (get-buffer-create "*pub_mount-buffer*")
			   "/Users/johndoe/bin/pub_mount.sh")
	    (message "Directory mounted, publish again for it to take effect"))
	(progn
	  (message "Not mounting directory, publication failed"))))))

(provide 'publish)
;;; publish.el ends here
