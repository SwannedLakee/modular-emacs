;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; [modular-emacs]:~/.emacs.d/lisp/modules/01-repositories.el
;;
;; Change Log:
;;   2019-002-05 - added melpa-stable.  Removed Marmalade which is dead now...
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;; Load package.el - Modified 2019-002-05 (Added the 3 Main Emacs package Repositories)
(require 'package)

;;Add melpa-stable to list of repositories:
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
             t)

;;Add melpa to list of repositories:
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") 
             t)

;;Initialize package.el
(package-initialize)
