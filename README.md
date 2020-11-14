# PerlDB-Command-Fix
#### Wraps GUD's perldb and properly quotes or escapes the formatted command line.

The perldb that is part of GUD creates a default command line to run the [Perl](http://www.perl.org/) script in debugger mode but fails to put the path to the script in quotes or escape special characters.  This package wraps GUD's perldb and injects a properly formatted command line into the gud-perldb-history list so that it appears when the actual perldb is called.


## Installation

Most simply, use `make`:

        $ sudo make install

The install implies the compilation so one command is enough.  For the whole sequence do:

        $ make
        $ sudo make install
        $ make clean

The clean just removes the `.elc` files.

If more control is needed, then these environment variables are available to set:

* `EMACS`     - Path to the Emacs executable.  Defaults to `emacs` with no directory so `$PATH` is searched. 
* `PREFIX`    - Defaults to `/usr/local`.
* `SITE_LISP` - Defaults to `${PREFIX}/share/emacs/site-lisp`.  Where the package will be installed.

#### Invocation

Loading the module will apply the wrapper to `perldb` using the [Emacs Advice](http://www.gnu.org/software/emacs/manual/html_node/elisp/Advising-Functions.html) functionality.  Put the following `require` in your `.emacs`, likely within a `perl-mode-hook` so it's loaded only when editing a [Perl](http://www.perl.org/) script.

        (require 'perldb-command-fix) ; Fix the unquoted file path when starting


## Usage

Just start `perldb` in the usual way, `M-x perldb` or bound key.  When the prompt is shown in the minibuffer it will have quotes around the [Perl](http://www.perl.org/) file name.  The space in the path name is now safe!

        Run perldb (like this): perl -d "/home/me/Git Repositories/Project/test.pl"


## Side Note

For anyone who just said, "Just don't put spaces in your file or folder names," they need to be (figuratively) slapped up side the head for being a lazy programmer.  Even though spaces are not part of the [POSIX Portable Filename Character Set](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_282) they are not expressly excused and are very common in modern windowed desktop interfaces, i.g. `Macintosh HD` in MacOS.  Spaces and other characters aren't that hard to account for.

## Version

<!-- $Id$ -->

$Revision$<br>$Tags$

## Copyright

&copy; 2020 Bion Pohl/Omega Pudding Software Some Rights Reserved

$Author$<br>$Email$
