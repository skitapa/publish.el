;;; publish.el --- Copy a buffer to a sshfs mounted folder somewhere
;; Copyright (C) 2011 Free Software Foundation, Inc.
;; Author Jimmy Arogén
;; version 0.000001
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
  (setq publish_dir "/Users/jimmy/slask/emacs");; Set your publishing dir here without trailing slash
  (if (file-exists-p "/Users/jimmy/testserver/private/index.php");; checks if mounted, place file there or use available
      (progn (progn (mark-whole-buffer)
       (write-region nil (point-max) (concat publish_dir (substring (buffer-file-name) 29)))) (deactivate-mark))
    (message "The directory is not mounted!")
    )
  )

(provide 'file_play)
;;; publish.el ends here

