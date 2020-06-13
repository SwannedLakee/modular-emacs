;;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; [modular-emacs]:~/.emacs.d/lisp/modules/02-package-conf.el
;;
;; This module provides the basic modules that most likely will be needed
;; by most all use-cases...  Modular Emacs default packages so-to-speak...
;;
;; Change Log:
;;
;; 2020-005-16 - Alisha Awen, siren1@disroot.org
;;   disabled poserline mode-line stuff...  I got tired of it...  Too busy...
;;   I found smart-mode-line to be better for my needs... That is the new
;;   default going forward.  I left the powerline code in, (disabled) in case
;;   you like it and would like to switch back...
;;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;;
;; Create repositories cache, if required

(when (not package-archive-contents)
  (package-refresh-contents))

;;;
;; Declare default modular-emacs list of required packages:

(defvar me--required-packages
  '(exec-path-from-shell
    gnu-elpa-keyring-update
    helm
;    powerline
;    smart-mode-line
    imenu-list
    auto-complete
    which-key
    flyspell-correct-helm))

;;;
;; Install required packages

(mapc (lambda (p) (package-install p))
      me--required-packages)


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Load Environment Vars from shell:
;; If we are using unix in a POSIX compliant shell...
;; (e.g., OS X, Linux, BSD, with POSIX: Bash, or Zsh etc.)
;; Reference: GitHub:Purcell/exec-path-from-shell
;; Install: from MELPA exec-path-from-shell

(when *is-posix* (exec-path-from-shell-initialize))


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;  imenu and imenu-list configuration:

;(require imenu-list)

(setq imenu-auto-rescan t)
;(setq imenu-list-focus-after-activation t)
;(setq imenu-list-auto-resize nil)


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Load default auto-complete configs

(ac-config-default)


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Start which-key-mode

(which-key-mode)


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Default Mode Line Tweaks:
;; Here are some nice tweaks that work fine with
;; Default mode lines as well as fancy mode-line
;; packages... currently I am just using the built
;; in mode-like package that comes with Emacs...

(setq size-indication-mode nil
      column-number-mode t
      line-number-mode t)

;;
;; Trim some minor mode’s display to a single unicode icon:

(dolist (mim '((auto-revert-mode   . "♺")
              (auto-fill-function . "⤶")
              (visual-line-mode   . "⤵")
              (isearch-mode       . "⁇")
              (paredit-mode       . "⁐")
              (xah-fly-keys       . "∑fk")
              (smartparens-mode   . "⦅⦆")))

  (let ((mode (car mim))
        (repl (list (concat " " (cdr mim)))))

    (when (assq (car mim) minor-mode-alist)
      (setf (cdr (assq (car mim) minor-mode-alist)) repl))))

;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Configure & Enable Smart-mode-line:
;; DISABLED - I no longer wish to mess with fancy
;;            mode lines... The default works fine
;;            for me. ;-) Your mileage may vary...

;;  Choose SML Theme:
;;  NOTE:   THIS IS DISABLED
;;    (I am no longer using mode-line packages)
;;    (pick one and enable it if you like but also
;;    load the theme at top first!)

;(setq sml/theme 'dark)
;(setq sml/theme 'light)
;(setq sml/theme 'respectful)

;; Enable Smart Mode Line after Emacs Startup:
;; NOTE: THIS IS DISABLED (see above note)
;(add-hook 'after-init-hook 'sml/setup)

;;; POWERLINE MODE DISABLED
;;  If you would rather use powerline, enable the three forms below
;;  and disable the above smart-mode-line section if you enabled it
;;  previously...
;;  Also make sure to load the mode at the top in the package install
;;  section!
;;
;; Enable powerline:
;(require 'powerline)
;(powerline-center-theme)
;(setq powerline-default-separator 'slant)


;; Platform Specific SML directory abbreviations:
;; NOTE: THIS IS DISABLED - Just as above you need to
;;       un-comment this section and make sure other smart-mode-line
;;       sections above are enabled first... (also load the package
;;       at the very top in the package install section)...
;;
;;  This is a demo list... It probably works for your .emacs.d directory
;;  and standard Docs directory, but you will need to fill in the path to
;;  the last element in the list to a real directory on your system
;;  (one which you would like to make a shortcut abbreviation for...
;;  Add more just like that to the end of the list (as instructed in the
;;  comment at the end of the list)

;; Platform Specific SML directory abbreviations:

;(when *is-darwin*
;  (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/" ":EMACS:"))
;  (add-to-list 'sml/replacer-regexp-list '("^~/Documents/" ":DOCS:"))
;  ;; Add more platform specific directory shortcut abbreviations to this list here as needed....
;  ;; When you are done adding new abbreviations, get rid of this comment and pull up the
;  ;; final parenthesis below to tidy up %^)...
;  )

;(when *is-linux*
;  (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/" ":EMACS:"))
;  (add-to-list 'sml/replacer-regexp-list '("^~/Documents/" ":DOCS:"))
;  ;; Add more platform specific directory shortcut abbreviations to this list here as needed....
;  ;; When you are done adding new abbreviations, get rid of this comment and pull up the
;  ;; final parenthesis below to tidy up %^)...
;  )

;; Platform Independent SML directory abbreviations:

;  (add-to-list 'sml/replacer-regexp-list '("^:DOCS:/Path/To/Your/Other/Docs/" ":My-Other-Docs:"))

;; Add more platform independent directory shortcut abbreviations just like the last form above...
;; These are invoked independently as complete forms here... No cleanup or closing paren needed when
;; adding to the end of this list...


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Set up helm-mode:

(helm-mode 1)
(helm-autoresize-mode 1)
(setq helm-split-window-in-side-p t)


;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;  Modular Emacs - Set Default Face Functions:
;;
;;  Purpose:
;;
;;    I like to use a serif mono font for writing paragraphs...
;;    but I use Hermit or other similar font for Coding...
;;    This provides a way to go back and fourth from one
;;    face (which is Emacs Default) to another depending on
;;    my current work mode (writing or coding)...
;;
;;  Usage:
;;
;;    Adjust face dimensions and weight within forms below as needed.
;;    Note: Linux vs Mac, Big screen vs Laptop, may require
;;          sub cases to handle... %^)
;;
;;    Xah Fly Key Assigned: Command Mode "p"
;;
;;  NOTE: Currently there is no check to see if these fonts are 
;;        installed on your system! This is still alpha test stage..."
;;

;; Set Default face to Org face Function:

(defun me_set-org-face ()
  "Set default face to Courier Prime Emacs (A nice mono serif for writing)"
  ;; NOTE: This only sets the face for the currently Selected Frame...
  ;;       (other frames are not affected)
  (interactive)
  (progn
    (set-face-attribute 'default (selected-frame)
                        :family "Courier Prime Emacs"
                        :slant 'normal
                        :height 138
                        :weight 'normal
                        :width 'normal)
    ;; Modify Frame dimensions for Writing with Olivetti mode enabled...
    (modify-frame-parameters nil
                             (quote
                              ((name . "HA Mod Emacs - Writing Mode")
                               (height . 38)
                               (width . 100))))
    ;;;
    ;; Enable Olivetti Mode with "normal line width" for writing:
    ;; Note:  I disabled this for Normal Writing mode.  Decided the
    ;;        User instead can decide if they need it.  Olivetti can be
    ;;        toggled with the single backquote "`" key if Xah-Fly-Keys
    ;;        Command Mode is enabled...

    ;; (if olivetti-mode
    ;;     (progn
    ;;       (olivetti-set-width 88))
    ;;   (progn
    ;;     (olivetti-mode)
    ;;     (olivetti-set-width 88)))
   ))


;; Restore Default Face Function:

(defun me_set-default-face ()
  "Set default font to Hermit Medium (my faverite mono font for coding)"
  ;; NOTE: This only sets the face for the currently Selected Frame...
  ;;       (other frames are not affected)
  (interactive)
  (progn
    (set-face-attribute 'default (selected-frame)
                        :family "Hermit"
                        :slant 'normal
                        :height 120
                        :weight 'normal
                        :width 'normal)
    (modify-frame-parameters nil
                             (quote
                              ((name . "HA Mod Emacs - Coding Mode")
                               (height . 32)
                               (width . 105))))))


;;;
;;  Toggle Default Face...
;;  NOTE: This only sets the face for the currently Selected Frame...
;;       (other frames are not affected) 
;;
;;  This one gets bound to Xah Fly Command Key:  "p"
;;  This one calls one of the two above depending on test variable:  me--default
;;  if me--default is t
;;    Switch to Org Mode
;;    Change me--default to nil
;;  Otherwise
;;    Switch back to default face
;;    Change me--default to t

(defvar me--def-face 1 "Test variable for me_toggle-default-face")

(defun me_toggle-default-face ()
  "Toggle default face for selected frame only,
   depending on current editing needs...
   Purpose: I like to use a serif mono font for writing
   paragraphs, but I need to use Hermit etc. for Coding
   This provides a way to toggle from one to the other"
  (interactive)
  (cond
   ((= me--def-face 1)
    (message "Setting default face to Courier Prime Emacs")
    (me_set-org-face)
    (setq me--def-face 2))
   ((= me--def-face 2)
    (message "Setting default face back to normal code font")
    (me_set-default-face)
    (setq me--def-face 1))))

;;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; END: [modular-emacs]:~/.emacs.d/lisp/modules/02-package-conf.el
;;;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
