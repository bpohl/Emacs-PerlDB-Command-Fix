# PerlDB-Command-Fix
#### Wraps gud's perldb and properly quotes or escapes the formatted command line.

The perldb that is part of gud creates a default command line to run the Perl script in debugger mode but fails to put the path to the script in quotes or escape special characters.  This package wraps gud's perldb and injects a properly formatted command line into the gud-perldb-history list so that it appears when the actual perldb is called.


## Installation

Most simply, use `make`:

        $ make install

The install implies the compilation so one command is enough.  For the whole sequence do:

        $ make
        $ make install
        $ make clean

The clean just removes the `.elc` files.

If more control is needed, then these environment variables are available to set:

* `EMACS`     - Path to the Emacs executable.  Defaults to `emacs` with no directory so `$PATH` is searched. 
* `PREFIX`    - Defaults to `/usr/local`.
* `SITE_LISP` - Defaults to `${PREFIX}/share/emacs/site-lisp`.

#### Invocation

Just loading the module will substitute the original `perldb` with the version in the wrapper.  The original `perldb` is renamed `gud-perldb` and it is still called after the wrapper has made the new Perl command.  Put the following `require` in your `.emacs`, likely within a `perl-mode-hook` so it's loaded only when editing a Perl script.

        (require 'perldb-command-fix) ; Fix the unquoted file path when starting


## Usage

Just start `perldb` in the usual way, `M-x perldb` or bound key.  When the prompt is shown in the Mini-Buffer it will have quotes around the Perl file name.  The space in the path name is now safe!

        Run perldb (like this): perl -d "/home/me/Git Repositories/Project/test.pl"


## Version

<!-- $Id$ -->

$Revision$<br>$Tags$

## Copyright

&copy; 2020 Bion Pohl/Omega Pudding Software Some Rights Reserved

$Author$<br>$Email$
