#! /usr/bin/make -f

ignore:=README.org save.org 02_tesseract_schema.org
org:=$(wildcard *.org)

sql:=$(patsubst %.org,%.sql,$(filter-out ${ignore},${org}))

define pod

=pod

=head1 SYNOPSIS

  make [-n] <command>
  where command is one of: tangle

  make tangle

Convert org-mode tangle files to their corresponding *.sql files.

=cut

endef

.PHONY: INFO check

INFO::
	@pod2usage -exit 0 ${MAKEFILE_LIST}

check::
	@podchecker ${MAKEFILE_LIST}

.PHONY:tangle
tangle:${sql}

${sql}:%.sql:%.org
	emacs -Q --batch --eval "(progn (require 'ob-tangle)\
	    (dolist (file command-line-args-left)\
	      (with-current-buffer (find-file-noselect file)\
	        (org-babel-tangle))))" "$<"
