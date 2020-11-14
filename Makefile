# Generic Emacs Make
# $Id$
# $Revision$
# $Tags$
#
# The Three Laws of Robotics
# 1. A robot may not injure a human being or, through inaction, 
#    allow a human being to come to harm.
# 2. A robot must obey orders given it by human beings except 
#    where such orders would conflict with the First Law.
# 3. A robot must protect its own existence as long as such 
#    protection does not conflict with the First or Second Law.
#                                                -- Isaac Asimov
#

# Generic compile and install for Emacs modules
# Compiles anything with a .el extension and install the resulting
# .elc in the non-version-specific site-lisp directory.

# Get a list of the .el in the current dir and rename them with .elc
PACKAGE_NAMES = $(patsubst %.el, %.elc, $(wildcard *.el))
$(info PACKAGE_NAMES = ${PACKAGE_NAMES})

# Set the shell and emacs as the compiler
SHELL := /bin/sh
EMACS ?= emacs

# Set install location
PREFIX    ?= /usr/local
SITE_LISP ?= ${PREFIX}/share/emacs/site-lisp


# Default rule to do every .el/.elc files
all: ${PACKAGE_NAMES}

# Compile the Lisp file
${PACKAGE_NAMES}: %.elc: %.el
	${EMACS} -batch -f batch-byte-compile $<

# Install all the .elc files in a site-lisp dir
.PHONY: install
install: ${PACKAGE_NAMES}
	@install -vd ${SITE_LISP}
	@install -vm 644 $^ ${SITE_LISP}/

# Remove all the .elc files that have .el files
.PHONY: clean
clean:
	@rm -v ${PACKAGE_NAMES}

