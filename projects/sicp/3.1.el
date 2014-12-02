;; -*- lexical-binding: 1; -*-
;; #1. balance is not yet localised.
(setq balance 100)
(defun withdraw (amount)
  (if (> amount balance)
      "insufficient fund!"
    (progn
      (setq balance (- balance amount))
      balance
      )
    )
  )
(withdraw 1)
;; #2 practise lambda syntax
(lambda () 1)
  
((lambda ()
  1) )

(lambda (x) (+ 1 x))

( (lambda (x) (+ 1 x)) 1)

;; #4 practise let syntax
(setq a1
(let ((a 1))
  (progn
  ((lambda () 1))
  
  )
)
)
(setq a2
(let ((a 1))
  (progn
  ((lambda () 1))
  
  )
)
)
(eq  a1 a2)

;; #5 localise balance
; Reference anonymouse function at http://www.chemie.fu-berlin.de/chemnet/use/info/elisp/elisp_12.html
;(defvar withdraw2 nil) 
(setq  withdraw2 
       (let ((bal 100))
	 (lambda (amount)
	   (if (> amount bal)
	       "insufficient fund!"
	     (progn (setq bal (- bal amount)) 
		    bal)
	     )
	   ) 
	 ) 
       )

(funcall withdraw2   1 )
;; 6 lexical scoping
;; reference  : http://www.gnu.org/software/emacs/manual/html_node/emacs/Specifying-File-Variables.html
;https://www.gnu.org/software/emacs/manual/html_node/elisp/Using-Lexical-Binding.html#Using-Lexical-Binding
; http://en.wikipedia.org/wiki/Emacs_Lisp
;; define lexical-binding in the first line of the file.
;; reload the file for the lexical binding to be effective.

(defvar my-ticker nil)   ; We will use this dynamically bound
                              ; variable to store a closure.
     
(let ((x 0))             ; x is lexically bound.
  (setq my-ticker (lambda ()
		    (setq x (1+ x)))))
     
(funcall my-ticker)
