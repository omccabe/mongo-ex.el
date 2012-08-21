(defvar mongo-default-db "mydb"
  "If non-nil, this db will be auto-used")
(defvar mongo-command "mongo"
  "In case you need to do something fancy to start the mongo cli")

; This will take the function under the current point and send it to the mongo cli in a shell
; buffer
(defun execute-function-in-mongo()
  (interactive
   (progn
     (unless (get-buffer "*mongo-shell*")
       ; Spin up the mongo cli in another window
       (save-window-excursion
	 (progn
	   (shell "*mongo-shell*")
	   (let((proc (get-buffer-process (current-buffer))))
	     (comint-simple-send proc mongo-command)
	     (if mongo-default-db
		 (comint-simple-send proc (concat "use " mongo-default-db)))
	   ))))
     (save-excursion
       ; Get the current function and send it to mongo
       (js2-mark-defun)
       (copy-region-as-kill (region-beginning) (region-end))
       (switch-to-buffer-other-window "*mongo-shell*")
       (yank)
       (comint-send-input)
       (other-window 1)))))

(global-set-key "\C-c\C-m" 'execute-function-in-mongo)
