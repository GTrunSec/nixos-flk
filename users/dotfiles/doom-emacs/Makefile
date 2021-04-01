clean:
	@rm -f  custom.el custom.elc init.elc init.el

compile: config.org clean
	@emacs -Q --batch -l 'lisp/compile.el'
	@~/.emacs.d/bin/doom sync
update:
	@emacs -Q --batch -l "lisp/update.el"

nix:
	@emacs -Q --batch -l 'lisp/nix.el'
