;;; PerlDB Commandline Fix
;;; $Id: 6607d711ce2bc86ddcdac27e99234faaa38bc983$
;;; $Revision: Sun Apr 12 09:54:50 2020 -0500 on branch Ubuntu$
;;; $Tags: v1.0.1$
;;;
;;; The Three Laws of Robotics
;;; 1. A robot may not injure a human being or, through inaction, 
;;;    allow a human being to come to harm.
;;; 2. A robot must obey orders given it by human beings except 
;;;    where such orders would conflict with the First Law.
;;; 3. A robot must protect its own existence as long as such 
;;;    protection does not conflict with the First or Second Law.
;;;                                                -- Isaac Asimov
;;;
;;; 
;;; The perldb that is part of gud creates a default command line to
;;; run the Perl script in debugger mode but fails to put the path to
;;; the script in quotes or escape special characters.  This package
;;; wraps gud's perldb and injects a properly formatted command line
;;; into the gud-perldb-history list so that it appears when the
;;; actual perldb is called.

;; Load gud so perldb, gud-perldb-command-name, and gud-perldb-history
;; are available
(require 'gud)

;; Make a new symbol that points to the real perldb and free the
;; symbol perldb
(declare-function gud-perldb "perldb-command-fix" (&optional command-line))
(fset 'gud-perldb (symbol-function 'perldb))
(fmakunbound 'perldb)

;; Define the new perldb 
(defun perldb (&optional command-line)
  "Wrapper to perldb that quotes the file path."
  (interactive)
  (if command-line
      (gud-perldb command-line)
    (progn
      (if buffer-file-name
          (add-to-list 'gud-perldb-history
                       (format "%s %S" gud-perldb-command-name
                               buffer-file-name)))
      (call-interactively 'gud-perldb))))

;; Copy the original documentation to the new perldb and add to it.)
(function-put 'perldb 'function-documentation
              (concat (replace-regexp-in-string "(fn .+?)" ""
                                                (documentation 'gud-perldb t))
                      "This version is a special wrapper that quotes and "
                      "escapes the path\nto the script file."))

(provide 'perldb-command-fix)
