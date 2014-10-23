;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



;; quick export to wik
(defun org-export-as-wik ()
  (interactive)

  (org-export-as-html 3)

  (find-file (replace-regexp-in-string "\.org$" ".html" (buffer-file-name)))

  ;; 1. after exporting to html, delete "file://c:/Users/ao1/Documents/wikiservermsw_1_5_11c/Pages/"
  (while (search-forward "file:////apsgsgpfile001/Shared002/Logix/Temp/AlanO/mirror/wiki/Pages/" nil t)
    (replace-match "" nil t))


  (while (search-forward "file:////apsgsgpwltang2/Projects/wiki/wikiservermsw_1_5_11c/Pages/" nil t)
    (replace-match "" nil t))

  (while (search-forward "file://c:/Users/ao1/Documents/wikiservermsw_1_5_11c/Pages/" nil t)
    (replace-match "" nil t))
  ;; 2. enclose with @html and @endhtml
  (beginning-of-buffer)
  (insert-string "@html\n")
  (end-of-buffer)
  (insert-string "@endhtml\n")
  
  ;; 3. rename file to wik
  (delete-file (replace-regexp-in-string "\.html$" ".wik" (buffer-file-name)))
;  (kill-buffer (buffer-name))
  (save-buffer)
  (rename-file (buffer-file-name) (replace-regexp-in-string "\.html$" ".wik" (buffer-file-name)))

  (setq bnhtml (buffer-name))
  (find-file (replace-regexp-in-string "\.html$" ".wik" (buffer-file-name)))

  (kill-buffer bnhtml)

;  (replace-regexp-in-string "\.html$" ".wik" "htmlopener.html")
)
(global-set-key "\C-cw" 'org-export-as-wik)
;; http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-dot.html
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot


;; Using this method you’ll find frequently used bookmarks easily (cho-seiri-hou in Japanese). – rubikitch

(defadvice bookmark-jump (after bookmark-jump activate)
  (let ((latest (bookmark-get-bookmark bookmark)))
    (setq bookmark-alist (delq latest bookmark-alist))
    (add-to-list 'bookmark-alist latest)))


(desktop-save-mode 1)

;; show the name of function where the cursor is in.
(which-function-mode 1)

(setq frame-title-format '((:eval default-directory)))
(defvar fold-state 0 "the state of fold-code-toggle function")
(defun fold-code-toggle()
  (interactive)
  (if (eq fold-state 1)
      (set-selective-display (+ 1 (current-column)))
    (set-selective-display 0)
    )
  (setq fold-state (% (+ fold-state 1) 2))
)

(global-set-key "\C-c\C-f" 'fold-code-toggle)
(defun maruo () 
  (interactive)
  (async-shell-command (concat "C:\\Tool\\Common\\Maruo\\v8.41\\Maruo.exe " (buffer-file-name)))
)

(defun iep () 
  (interactive)
  (async-shell-command (concat "C:\\Tool\\Common\\iep\\v3.4\\iep.exe " (buffer-file-name)))
)

;; suddenly my .emacs and bookmark disappear. This measure shall ensure that it is backed up everytime, emacs shuts down.
(defun save-files-on-shutdown ()
  "save .emacs , bookmark to a safe location before shutdown"
  (copy-file "~/.emacs" "c:/.emacs" "OK")
  (copy-file "~/.emacs.d/bookmarks" "c:/bookmarks" "OK")

  (copy-file "~/.emacs" "//apsgsgpfile001/Shared002/Logix/Temp/AlanO/" "OK")
  (copy-file "~/.emacs.d/bookmarks" "//apsgsgpfile001/Shared002/Logix/Temp/AlanO/" "OK")

  ;; (message "Backing up wikiserver to shared drive...")
  ;; (shell-command "c:/Users/ao1/Documents/wikiservermsw_1_5_11c/encrypt.bat")
  ;; (message "Backup Completed!")
)

(add-hook 'kill-emacs-hook 'save-files-on-shutdown)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					;    Filename : .emacs
					; Description : configuration file for Conti emacs
					;      Author : Alan O Hung Lun
					; ------------------------------------------------------------------------------------------------
					;     History :
					;                - modify my-put-file-name-on-clipboard to toggle backward slash and forward slash in file path.
					;		 V1.0 : Inital revision
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; mapping of window executable to internal variables.
;;(setq bcompareexe "\"C:\\Program Files (x86)\\Beyond Compare 3\\BCompare.exe\"" )
;;(setq chromexe "\"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe\" ")
(setq firefox "\"c:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\" ")
(setq explorer "\"c:\\Program Files (x86)\\Internet Explorer\\iexplore.exe\" ")
;; openwith
;; (add-to-list 'load-path "d:/Tool/Common/emacs-24.3/site-lisp/openwith.el")
;; (require 'openwith)
;; (setq openwith-associations '(("\\.doc\\'" "d:/work/tools/word.bat" (file))))

;; unique lines
(defun uniquify-region-lines (beg end)
  "Remove duplicate adjacent lines in region."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
      (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))

;; disable screen splash
(setq inhibit-splash-screen t)

;; Org-mode settings
(defun my-org-mode ()
  (org-mode)
  ;;  (auto-fill-mode)
  )
;; quick access to TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)"  "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" "CANCELED(c)")
	(sequence "|" "CANCELED(c)")))

(add-to-list 'auto-mode-alist '("\\.txt$" . my-org-mode ))
(add-to-list 'auto-mode-alist '("\\.org$" . my-org-mode ))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-set-key "\C-ce" 'org-export-as-html)
(global-font-lock-mode 1)
(setq org-default-notes-file "~/journal.org")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;modify the values in org-export option here
;;see org-export-plist-vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-chinese-all-holidays-flag t)
 '(desktop-save-mode t)
 '(dnd-open-file-other-window t)
 '(holiday-bahai-holidays (quote ((if calendar-bahai-all-holidays-flag (append (holiday-bahai-new-year) (holiday-bahai-ridvan) (holiday-fixed 5 23 "Declaration of the Báb") (holiday-fixed 5 29 "Ascension of Bahá'u'lláh") (holiday-fixed 7 9 "Martyrdom of the Báb") (holiday-fixed 10 20 "Birth of the Báb") (holiday-fixed 11 12 "Birth of Bahá'u'lláh") (holiday-fixed 11 26 "Day of the Covenant") (holiday-fixed 11 28 "Ascension of `Abdu'l-Bahá"))))))
 '(holiday-general-holidays (quote ((holiday-fixed 1 1 "New Year's Day"))))
 '(holiday-hebrew-holidays (quote ((if calendar-hebrew-all-holidays-flag (append (holiday-hebrew-passover) (holiday-hebrew-rosh-hashanah) (holiday-hebrew-hanukkah) (holiday-hebrew-tisha-b-av) (holiday-hebrew-misc))))))
 '(holiday-islamic-holidays (quote ((holiday-islamic 10 1 "Hari Raya Puasa") (holiday-islamic 12 10 "Hari Raya Haji") (holiday-islamic 9 1 "Ramadan Begins") (if calendar-islamic-all-holidays-flag (append (holiday-islamic-new-year) (holiday-islamic 1 10 "Ashura") (holiday-islamic 3 12 "Mulad-al-Nabi") (holiday-islamic 7 26 "Shab-e-Mi'raj") (holiday-islamic 8 15 "Shab-e-Bara't") (holiday-islamic 9 27 "Shab-e Qadr"))))))
 '(holiday-local-holidays (quote ((append (holiday-fixed 8 9 "Singapore National Day")))))
 '(holiday-other-holidays (quote ((if (zerop (- (calendar-extract-year (calendar-current-date)) 2013)) (append (holiday-fixed 12 23 "Conti Close Down D1") (holiday-fixed 12 24 "Conti Close Down D2") (holiday-fixed 12 26 "Conti Close Down D3") (holiday-fixed 12 27 "Conti Close Down D4") (holiday-fixed 12 30 "Conti Close Down D5"))))))
 '(ls-lisp-emulation nil)
 '(ls-lisp-verbosity nil)
 '(org-agenda-files (quote ("~/journal.org")))
 '(org-emphasis-alist (quote (("*" bold "<b>" "</b>") ("/" italic "<i>" "</i>") ("=" org-code "<code>" "</code>" verbatim) ("~" org-verbatim "<code>" "</code>" verbatim) ("+" (:strike-through t) "<del>" "</del>"))))
 '(org-export-email-info t)
 '(org-export-html-postamble t)
 '(org-export-html-table-tag "<table border=\"2\" cellspacing=\"0\" cellpadding=\"6\" rules=\"all\" frame=\"border\">")
 '(org-todo-keywords (quote ((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)"))))
 '(org-use-sub-superscripts (quote {}))
 '(send-mail-function (quote mailclient-send-it))
 '(tool-bar-mode nil)
 '(user-mail-address "ao1@ra.rockwell.com"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "snow" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Courier New")))))


;; Org Capture
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/journal.org" "Tasks")
         "* TODO %?\n  Entry Date:%u\n")
	("n" "Note" entry (file+headline "~/journal.org" "Notes")
         "* %?\nEntry Date:%u\n")
	("b" "Blog" entry (file+headline "~/journal.org" "Blog")
         "* %?\nEntry Date:%u\n")
	("q" "Question" entry (file+headline "~/journal.org" "Question")
         "* TODO %?\nSCHEDULED: %t\nDescription:\nAnswer:\n")
	("w" "Wish" entry (file+headline "~/journal.org" "Wishes")
         "* %?\nEntry Date:%u\n")
	("g" "Gebet" table-line (file+headline "~/journal.org" "Gebet")
         "|%u|%?| |\n")
	("s" "Shortcut" table-line (file+headline "~/journal.org" "Shortcut")
         "|%?| |\n")

	))

(put 'narrow-to-region 'disabled nil)



;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%b (%f)")

;; copy file path to clipboard
(defun backward-slash-path ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
	(beginning-of-buffer)
;	(if (string=  (read-from-minibuffer "Backward slash? " nil nil t nil "b") "b")
	(while (search-forward "/" nil t)
	  (replace-match "\\" nil t))
;	  )
        (clipboard-kill-region (point-min) (point-max)))
      (message (car kill-ring)))))

(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
	(beginning-of-buffer)
	(while (search-forward "/" nil t)
	  (replace-match "\\" nil t))

        (clipboard-kill-region (point-min) (point-max)))
      (message (car kill-ring)))))

(global-set-key "\M-q" 'backward-kill-word)

;(global-set-key "\C-cp" 'my-put-file-name-on-clipboard)
(global-set-key "\C-cp" 'my-put-file-name-on-clipboard)
;(global-set-key "\C-c]" 'backward-slash-path)


;; refresh buffer
(global-set-key "\C-c\C-r" 'revert-buffer)

;; use cygwin shell
(defun bash ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "c:/Tool/Common/cygwin/bin/bash"))
    (call-interactively 'shell)
					;    (shell "bash")
    ))

;; dot program
(add-to-list 'auto-mode-alist '("\\.dot$" . c-mode ))

;; refresh the graphic output from dot.
(defun dot-refresh-png-output ()
  ;; description run the dot command and open the png output
  ;; window photo viewer does not work with cygwin style file path.
  (interactive)
  (let* (
	 (curbuf (buffer-name))
	 (dotfile (buffer-file-name))
	 (png  (concat (substring dotfile 0 -3) "png"))
	 (cmd  (concat "dot -Tpng " dotfile " -o " png))
	 )

    (shell-command cmd)
    (async-shell-command (concat explorer png))
    (delete-other-windows)
    )
  )
(global-set-key "\C-cd" 'dot-refresh-png-output)


;; create png from dot command in buffer region
;; BUG : file path
(defun dot-region-png-output (beg end filename )
  ;; description :
  ;; execute the dot command in region
  ;; save the png output to d:/res/image/dot
  ;; return the path to the png output

  ;; implementation :
  ;; query for [filename]. 
  ;; define the dotfile path and output path with [filename] 
  ;; save the region to the dot file 
  ;; run dot program on the dot file
  ;; save the png path to kill ring.
  (interactive  "r\nM")
  (let* ( (outdir "d:/res/image/dot/" )
	  (dotfile (concat outdir filename ".dot"  ))
	  (pngout  (concat outdir filename ".png"))
	  (cmd  (concat "dot -Tpng " dotfile " -o " pngout))
	  )
    (message dotfile)
    (write-region beg end dotfile)
    (shell-command cmd)
    (message pngout)
    (kill-new (concat "[[" pngout "][" pngout "]]"))
    )

  )


;; startup    

;; open file with external program

(defun prelude-open-with ()
  "Simple function that allows us to open the underlying
file of a buffer in an external program."
  (interactive)
  (org-mode)
  (when buffer-file-name4
    (org-open-file-with-system buffer-file-name))
  (doc-view-mode))


					;(defun open-with (filename &optional wildcards)
					;  "Simple function that allows us to open the underlying
					;file of a buffer in an external program."
					;  (interactive
					;   (find-file-read-args "Find file: " 
					;                        (confirm-nonexistent-file-or-buffer)))
					;  (let ((curbuf (buffer-name)))
					;    (switch-to-buffer "*scratch*" )
					;    (org-mode)
					;    (message filename)
					;    (message curbuf)
					;   
					;    (when filename
					;      (org-open-file-with-system filename))
					;    (switch-to-buffer  curbuf))
					;  )
(defun open-with ()
  "Simple function that allows us to open the underlying
file of a buffer in an external program."
  (interactive)
  (org-mode)
  (org-open-file-with-system buffer-file-name)
  (kill-buffer (buffer-name))
  )

(global-set-key "\C-co" 'open-with)

;; load user-modified dired package.
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;(add-to-list 'load-path "d:/Tool/Common/emacs-24.3/site-lisp/openwith.el")
;; call bcompare instead of diff in dired-diff
 ;; (defun bcompare (file current switches)
 ;;   (shell-command (concat bcompareexe " " file " " current))
 ;;   )
(defun bcompare (left right)
  "Compare with Beyond Compare"
  (interactive "GLeft: \nGRight: ")
  
  (let ((command (format "%s  %s %s" bcompareexe left right)))
;    (shell-command command)
    ;asynchronous command
    (start-process-shell-command "beyond compare" nil command)
    (message command) 
    )
  )
					;(bcompare "d:/tmp/pf3/Alan/vms_common/core/vmsxc1.h" "d:/tmp/pf3/Alan/vms_213/core/vmsxc1.h" nil)
;; (defun dired-diff (file &optional switches)
;;   "Compare file at point with file FILE using `diff'.
;; If called interactively, prompt for FILE.  If the file at point
;; has a backup file, use that as the default.  If the mark is active
;; in Transient Mark mode, use the file at the mark as the default.
;; \(That's the mark set by \\[set-mark-command], not by Dired's
;; \\[dired-mark] command.)

;; FILE is the first file given to `diff'.  The file at point
;; is the second file given to `diff'.

;; With prefix arg, prompt for second argument SWITCHES, which is
;; the string of command switches for the third argument of `diff'."
;;   (interactive
;;    (let* ((current (dired-get-filename t))
;; 	  ;; Get the latest existing backup file.
;; 	  (oldf (diff-latest-backup-file current))
;; 	  ;; Get the file at the mark.
;; 	  (file-at-mark (if (and transient-mark-mode mark-active)
;; 			    (save-excursion (goto-char (mark t))
;; 					    (dired-get-filename t t))))
;; 	  (default-file (or file-at-mark
;; 			    (and oldf (file-name-nondirectory oldf))))
;; 	  ;; Use it as default if it's not the same as the current file,
;; 	  ;; and the target dir is current or there is a default file.
;; 	  (default (if (and (not (equal default-file current))
;; 			    (or (equal (dired-dwim-target-directory)
;; 				       (dired-current-directory))
;; 				default-file))
;; 		       default-file))
;; 	  (target-dir (if default
;; 			  (dired-current-directory)
;; 			(dired-dwim-target-directory)))
;; 	  (defaults (dired-dwim-target-defaults (list current) target-dir)))
;;      (list
;;       (minibuffer-with-setup-hook
;; 	  (lambda ()
;; 	    (set (make-local-variable 'minibuffer-default-add-function) nil)
;; 	    (setq minibuffer-default defaults))
;; 	(read-file-name
;; 	 (format "Diff %s with%s: " current
;; 		 (if default (format " (default %s)" default) ""))
;; 	 target-dir default t))
;;       (if current-prefix-arg
;; 	  (read-string "Options for diff: "
;; 		       (if (stringp diff-switches)
;; 			   diff-switches
;; 			 (mapconcat 'identity diff-switches " ")))))))
;;   (let ((current (dired-get-filename t)))
;;     (when (or (equal (expand-file-name file)
;; 		     (expand-file-name current))
;; 	      (and (file-directory-p file)
;; 		   (equal (expand-file-name current file)
;; 			  (expand-file-name current))))
;;       (error "Attempt to compare the file to itself"))
;;     (bcompare file current switches)))


;; set up cscope 
(require 'xcscope)
;;
;;;;By default, xcscope.el does automatic indexing by use of a Bash script (cscope-indexer). As Windows lacks Bash support, automatic indexing is here disabled
;;(setq cscope-do-not-update-database t) 
;;;; key binding for cscope

(define-key global-map [(control f1)]  'cscope-find-this-text-string)
(define-key global-map [(control f2)]  'cscope-find-functions-calling-this-function)
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-next-symbol)
(define-key global-map [(control f10)] 'cscope-next-file)
(define-key global-map [(control f11)] 'cscope-prev-symbol)
(define-key global-map [(control f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)]  'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)



(defun date ()
  (interactive)
  (org-insert-time-stamp (current-time) t 'INACTIVE)
;  (shell-command "date" 1 1)
)
(global-set-key "\C-ct" 'date)


; 
; C-c ; Toggle the COMMENT keyword at the beginning of an entry
;
(defun org-comment (beg end)
  (interactive "r")
  (goto-char end) 
  (insert-string "\n#+END_COMMENT\n")
  (goto-char beg) 
  (insert-string "#+BEGIN_COMMENT\n")
  )


;; insert quotation tag in org-mode
(defun org-dot (beg end)
  (interactive "r")
  (goto-char end) 
;  (insert-string "}")
  (insert-string "\n#+END_SRC\n")
  (goto-char beg) 
  (insert-string "#+BEGIN_SRC dot :file dotimage.png  :exports results\n")
 ; (insert-string "digraph {\n")
 ; (insert-string "rankdir=LR  ;")

;#+BEGIN_SRC dot :file images/std_controller1.png  :exports results
)
(defun org-quote (beg end)
  (interactive "r")
  (goto-char end) 
  (insert-string "\n#+END_SRC\n")
  (goto-char beg) 
  (insert-string "#+BEGIN_SRC C\n")
  )
;; insert test switch in c program.
(defun test (beg end)
  (interactive "r")
  (goto-char end) 
  (insert-string "#else\n\n#endif //ODO_STANDALONE_TEST\n")
  (goto-char beg) 
  (insert-string "\n#ifdef ODO_STANDALONE_TEST\n")
  )

;; org mode to include holidays from Calendar
(setq org-agenda-include-diary t)


;; convert backward slash to forward slash in the last item of clipboard
(defun win2unix-paste ()
  ;;get the last item in ring
  ;;replace backward slash to forward slash
  (interactive)
  (with-temp-buffer
    (insert (car kill-ring))
    (beginning-of-buffer)
    (while (search-forward "\\" nil t)
      (replace-match "/" nil t))
    (clipboard-kill-region (point-min) (point-max)))
  ;;  (yank)
  )
;; replace yank with clipboard-b2f-paste
;;(global-set-key "\C-y" 'yank)

;; at startup show agenda view.
(org-agenda-list)


;; haskell mode via package manager
;; run : package-refresh-contents , then
;; README : package-install<ret>haskell-mode to install
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent) ;; turn on haskell indentation.
;; BUG : setting proxy
;; network proxy settings
;;(setq url-proxy-services
;;      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;	("http" .  "con-haj-asg-01.conti.de:8080")
;;	("https" . "con-haj-asg-01.conti.de:8080")))
;;
;;(setq url-http-proxy-basic-auth-storage
;;      (list (list "con-haj-asg-01.conti.de:8080"
;;		  (cons "uidw5065"
;;			(base64-encode-string "123qweAsd")))))
;;
;; enable line wrap visually.
(global-visual-line-mode t)

;; next window and previous window commmand
(global-set-key "\M-n" 'other-window)


(defun open-png-external ()
  ;; buffer-file-name has extension png
  ;; 
  (if (and (stringp buffer-file-name)
	   (string-match "\\.png\\'" buffer-file-name))
      (progn    
	(prelude-open-with)
					;    (kill-buffer (buffer-name))
	(message "PNG opened."))
    )

  )
(defun open-pdf-external ()
  ;; buffer-file-name has extension pdf
  (if (and (stringp buffer-file-name)
	   (string-match "\\.pdf\\'" buffer-file-name))
      (progn 
	(prelude-open-with)
	(message "PDF opened.")
	)
					;   (kill-buffer (buffer-name))
    )
  )
(defun dos2unix ()
  (let ((filepath buffer-file-name))
    (if (and (stringp filepath)
	     (string-match "\\.sh\\'" filepath))
	(progn 
	  (shell-command (concat "dos2unix " filepath))
	  (kill-buffer (buffer-name))
	  (find-file filepath)
	  (message "dos file converted to unix format")
	  )
      ))
  )
					;replace h: with \\igdb003.cw01.contiwan.com\uidw5065$ in file name
					;(defun replace-h ()
					;  (interactive)
					;  (beginning-of-line)
					;  (if  (search-forward-regexp "h:" nil t)
					;      (replace-match "\\\\\\\\igdb003.cw01.contiwan.com\\\\uidw5065$")
					;      )
					;  )
					;(global-set-key "\C-ch" 'replace-h)
					;

					;(add-hook 'after-save-hook 'dos2unix)
(add-hook 'find-file-hook 'open-png-external)
(add-hook 'find-file-hook 'open-pdf-external)
(remove-hook 'find-file-hook 'open-png-external)
(remove-hook 'find-file-hook 'open-pdf-external)

(defun unixpath (path)
  (interactive
   (list (read-string "dos path to convert: ") ))
  (let* ( (dospath0 (replace-regexp-in-string "\\\\" "/" path t t))
	  (dospath (concat "/cygdrive/" (replace-regexp-in-string ":" "" dospath0 t t)))
	  )
    (message dospath)
    (kill-new dospath)
    ))


(setenv "PATH" (concat "C:\\Tool\\Common\\cygwin\\bin;" "c:\\Tool\\Common\\MiKTeX\\v2.9\\miktex\\bin;" (getenv "PATH")))
;;debug network drive change.
;;change the url of each image file to a network url and copy it to network drive.
(defun org-copy-image-to-wikiserver ()
  (interactive)
  (let* ( 
	 (nwp "\\\\apsgsgpfile001\\Shared002\\Logix\\Temp\\AlanO\\mirror\\wiki\\Pages\\images\\sc")
;	 (nwp "\\\\apsgsgpwltang2\\Projects\\wiki\\wikiservermsw_1_5_11c\\Pages\\images\\sc")
;	 (nwp "\\\\apsgsgpfile001\\shared002\\Logix\\Temp\\AlanO\\sc")
	 )
    (beginning-of-buffer)
    (while  (search-forward-regexp "\\(C:.*\.png\\)\\|\\(C:.*\.jpg\\\)" nil t)
;    (while  (search-forward-regexp "C:.*\.png" nil t)
      (shell-command (concat "cp -v \"" (match-string 0) "\" " nwp ))
      )


    (beginning-of-buffer)
    (while  (search-forward-regexp "C:\\\\Users\\\\ao1\\\\Pictures\\\\sc" nil t)
      (replace-match  "\\\\\\\\apsgsgpfile001\\\\Shared002\\\\Logix\\\\Temp\\\\AlanO\\\\mirror\\\\wiki\\\\Pages\\\\images\\\\sc")
;      (replace-match "\\\\\\\\apsgsgpwltang2\\\\Projects\\\\wiki\\\\wikiservermsw_1_5_11c\\\\Pages\\\\images\\\\sc")
;      (replace-match "c:\\\\Users\\\\ao1\\\\Documents\\\\wikiservermsw_1_5_11c\\\\Pages\\\\images\\\\sc" )
;      (replace-match "images\\\\sc" )
     )
    )
  )   


					;  M-x replace-regexp <RET> ^.\{0,72\}$ <RET> */
					;     \,(format "%-72sABC%05d" \& \#) <RET> */
					;\,(format "%-80s %s" \1 \2) */
					;     \(.*)\).*\([0-9]+\) */
					;
(defun org-shift-down-cell ()
  (interactive)

  (org-table-align)

  (let ((start (point))
	(col (org-table-current-column))
	(line (org-table-current-line)))

					;navigate to the end of the field in the last line in the current column
    (goto-char (- (org-table-end) 3))
    (org-table-goto-column col)
    (org-table-next-field)
    (goto-char (- (point) 3))
					;kill the rectangle.
    (kill-rectangle start (point) )
    
					;add a new row at the table end.
    (org-return)
					;point to one row below the start line.
    (org-table-goto-line (1+ line))
    (org-table-goto-column col)
					;rectangle yank.     
    (yank-rectangle)

					;restore pointer and table alignment.
    (org-table-align)
    (goto-char start)

    )

  )

(global-set-key (kbd "C-c <down>") 'org-shift-down-cell)

(defun b2f ()
  "convert backward slash to forward slash"

  (interactive)
  (let ((cv case-fold-search))
    (setq case-fold-search "nil")
    (save-excursion
      (while  (search-forward-regexp "\\\\" nil t)
	(replace-match "/")
	)
      )
    ;; (save-excursion
    ;;   (while  (search-forward-regexp  (getenv "HOME") nil t)
    ;; 	(replace-match "~/")
    ;; 	)
    ;;   )

    (setq case-fold-search cv)
    )
  )
(global-set-key (kbd "C-c f") 'b2f)

(defun f2b ()
  "convert forward slash to backward slash"

  (interactive)
  (save-excursion
    (while  (search-forward-regexp "/" nil t)
      (replace-match "\\\\")
      )
    )

  )
(global-set-key (kbd "C-c b") 'f2b)

					;
					;(defun dnd-handler (event &optional new-frame)
					;       (interactive "e")
					;       (message "Got dnd signal"))
					;(global-set-key [drag-n-drop] 'dnd-handler)

					;start bash and shell


;;(shell-command "d:/.emacs.d/mapnetworkdrive.bat")

(defun quick_c_compile_run()
  (interactive)
  ;go to the other buffer
  (switch-to-buffer "*shell*")
  ;insert string and press enter
;  (insert-string "gcc -o geld geld.c ; ./geld")  
  (insert-string 
"dot -Tpng dependency_diagram.dot -o dependency_diagram.png"
)
  )
(global-set-key "\C-cq" 'quick_c_compile_run)


(defun my-signature-on-clipboard ()
  "Put my name and company on the clipboard"
  (interactive)
      (with-temp-buffer
        (insert "Alan O Hung Lun, Embedded Software Singapore")
	(beginning-of-buffer)
        (clipboard-kill-region (point-min) (point-max)))
      (message (car kill-ring)))
(defun fh()
  "Insert function header."
  (interactive)

  (insert "/***************************************************************************\n")
  (insert "* Interface Description: \n")
  (insert "*\n")
  (insert "* Implementation       : \n")
  (insert "*\n")
  (insert "* Return Value         : \n")
  (insert "*\n")
  (insert "* Author               : Alan O Hung Lun, I ID S2 AD SW 1\n")
  (insert "*\n")
  (insert "****************************************************************************/\n")
  (insert "\n")
  )
(defun insert-time-recording-template ()
  "Insert time recording template."
  (interactive)
  (insert "| Project | Phase | Start Date Time              | Int. Time | Stop Date Time               | Delta Time | Acc.|Comments |\n")
  (insert "|---------+-------+-----------------+-----------+----------------+------------+------+----------|\n")
  (insert "|         |       |                 |           |                |            |      |          |\n");
  (insert "#+TBLFM: $7=$6+@-1$7::@2$7=@2$6\n")
  (insert "*** Produce a requirement statement\n")
  (insert "*** Development\n")
  (insert "*** Postmortem\n")
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ALIAS BEGIN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defalias 'font-size-adjust 'text-scale-adjust)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ALIAS END;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;Reduce details in dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun org-work-recap ()
  (interactive)
  (switch-to-buffer "*scratch*")
  (org-mode)
  (goto-char (point-max))
  (insert (format "\n\n\n--Work done in %s------------------------------------------------------------------------------------------\n\n"  (format-time-string "%Y-%m-%d")))
  (shell-command (format "grep -e '^|.*%s'  ~/journal.org" (format-time-string "%Y-%m-%d") ) 1 1)

  (goto-char (point-max))

;    (shell-command "grep -e '^|.*2014-06-27' ~/journal.org" 1 1)
 )

; debug : download music player.
;music player
;http://www.gnu.org/software/emms/quickstart.html
;;(add-to-list 'load-path "~/.emacs.d/lisp/emms/lisp")
;;(require 'emms-setup)
;;(emms-standard)
;;(emms-default-players)
;;(setq emms-source-file-default-directory "C:\\Users\\ao1\\Music\\Music\\")
;;(setq exec-path (append exec-path '("D:\\private\\mplayer-svn-37232")))
;;; for more key binding : d:\.emacs.d\lisp\emms\lisp\emms-playlist-mode.el
;;(global-set-key (kbd "<f6>") 'emms-pause)
;;(global-set-key (kbd "<f7>") 'emms-show-alt)
;;(global-set-key (kbd "<f9>") 'emms-previous)
;;(global-set-key (kbd "<f10>") 'emms-next)
;;(emms-play-directory-tree emms-source-file-default-directory)
;;(emms-stop)
;;
;; enable copying between 2 dired window
(setq dired-dwim-target t)


;; set-default buffer-file-coding-system 'utf-8-unix)
;; (set-default-coding-systems 'utf-8-unix)
;; (prefer-coding-system 'utf-8-unix)
;; (set-default default-buffer-file-coding-system 'utf-8-unix)
(defun dos2unix ()
  "Convert a DOS formatted text buffer to UNIX format"
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil)
  )
(add-hook 'shell-mode-hook 'dos2unix) ;; turn on unix format

