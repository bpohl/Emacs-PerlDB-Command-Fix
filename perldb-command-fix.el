;;; PerlDB Commandline Fix
;;; $Id$
;;; $Revision$
;;; $Tags$
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
;;; The perldb that is part of GUD creates a default command line to
;;; run the Perl script in debugger mode but fails to put the path to
;;; the script in quotes or escape special characters.  This package
;;; wraps GUD's perldb and injects a properly formatted command line
;;; into the gud-perldb-history list so that it appears when the
;;; actual perldb is called.

;; Define variables from GUD for the compiler
(defvar gud-perldb-command-name)
(defvar gud-perldb-history)

;; Define the new (interactive) for perldb 
(defun perldb-command-fix (command-line)
  "Wrapper to perldb that quotes the file path."
  (interactive
   (lambda (spec)
     (if buffer-file-name
         (add-to-list 'gud-perldb-history
                      (format "%s %S" gud-perldb-command-name
                                      buffer-file-name)))
     (advice-eval-interactive-spec spec))))

;; Tell Emacs that perldb-command-fix comes before perldb
(advice-add 'perldb :before #'perldb-command-fix)


(provide 'perldb-command-fix)
