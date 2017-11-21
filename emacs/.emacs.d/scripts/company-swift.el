(require 'url-util)
(defcustom company-swift-curl
  (executable-find "curl")
  "Location of curl executable."
  :type 'file)

(defcustom company-swift-daemon-url
  "localhost:8081"
  "Host:port pair of the sourcekittendaemon."
  :type 'stringp)

(defvar company-swift-modes '(swift-mode)
  "Major modes in which may complete.")

(defun company-swift--make-candidate (candidate)
  (let ((text (car candidate))
        (meta (cadr candidate)))
    (propertize text 'meta meta)))

(defun company-swift--parse-output ()
  (let (lines)
    (dolist (line (split-string (buffer-string) ";\n" t))
      (push (company-swift--make-candidate (split-string line "\t"))
            lines))
    lines))

(defun company-swift--candidates (prefix)
  (let ((location (- (point) (length prefix)))
        (file (file-name-nondirectory buffer-file-name))
        (buffer (current-buffer))
        (url (format "%s/complete?format=yasnippet&prefix=%s"
                     company-swift-daemon-url (url-hexify-string prefix)))
        path)

    (setq path (make-temp-file file))
    (with-temp-file path
      (insert-buffer-substring buffer))

    (with-temp-buffer
      (call-process company-swift-curl nil t nil
                    "--silent"
                    "-H" (format "X-File: %s" file)
                    "-H" (format "X-Path: %s" path)
                    "-H" (format "X-Offset: %d" location)
                    url)
      (company-swift--parse-output))
    ))

(defun company-swift--meta (candidate)
  (substring-no-properties candidate))

(defun company-swift--expand (candidate)
  (let ((template (get-text-property 0 'meta candidate))
        (start (- (point) (length candidate))))

    (if (string-prefix-p "?" template)
        (setq start (- start 1)))

    (yas-expand-snippet template start (point))))

(defun company-swift (command &optional arg &rest ignored)
  "`company-mode' completion back-end for sourcekittendaemon."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-swift))
    (prefix (and (memq major-mode company-swift-modes)
                 (not (company-in-string-or-comment))
                 (company-grab-symbol-cons "\\.\\|(" 1)))
    (candidates (company-swift--candidates arg))
    (meta (company-swift--meta arg))
    (post-completion (company-swift--expand arg))
    (sorted 't)
    (ignore-case 't)
    ))
