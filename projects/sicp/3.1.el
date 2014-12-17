;; -*- lexical-binding: 1; -*-
;; #1. balance is not yet localised.
(setq lexical-binding 1)
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

;; 7 
;; variant of defining local state of a function.
(defun withdraw3 (balance)
  (lambda (amount)
    (progn
      (setq balance (- balance amount))
      balance
      )
    )

  )
(setq w1 (withdraw3 40))
(funcall w1 2)
(setq w2 (withdraw3 140))
(funcall w2 3)

; 8. message passing and state modelling trial
(defun make-account (balance)
  (defun t3 ()
    (+ balance 11)
    )
  (function t3)
  )
(setq a1 (make-account 100))
(funcall a1)
;(funcall t3) ; t3 is void symbol; hidden within make-account object.
(funcall '(lambda (xx) (+ xx 1)) 1)
(setq t2 withdraw2)
(t3)

; 9. lambda, defun, function and #'
(defun x () "hello")
(setq y (lambda () "world!"))
(x)
(funcall (function x))
(funcall #'x)
(funcall y)

; 8. message passing and state modelling trial
; balance becomes a class variable in this implementation.
; every instantiation changes the value of this class variable!
(defun make-account2 (balance)
  
  (defun withdraw (amount)
    (progn
      (setq balance (- balance amount))
      balance
    ))
  (defun deposit (amount)
    (progn
      (setq balance (+ balance amount))
      balance
    ))
  (lambda (m)
    (cond ( (string= m 'withdraw) (function withdraw))
	  ( (string= m 'deposit) (function deposit))
	  ( t "make-account : Unknown method requested") )
    )
  )
(setq b1 (make-account2 100))
(funcall (funcall b1 'withdraw) 7)
(funcall (funcall b1 'deposit) 7)
(setq b2 (make-account2 1100))
(funcall (funcall b2 'withdraw) 7)
(eq (funcall b1 'withdraw) (funcall b2 'withdraw))

; balance is an object variable here in this implementation. The only CORRECT closure implementation.
(defun make-account (balance)
  (lambda (m)
    (cond ( (string= m 'withdraw) (lambda  (amount)
				    (progn
				      (setq balance (- balance amount))
				      balance
				      )))
	  ( (string= m 'deposit)   (lambda  (amount)
				     (progn
				       (setq balance (+ balance amount))
				       balance
				       )))
	  ( t "make-account : Unknown method requested") )
    )
  )
balance
(setq a1 (make-account 100))
(funcall (funcall a1 'withdraw) 7)
(funcall (funcall a1 'deposit) 7)
(setq a2 (make-account 1100))
(funcall (funcall a2 'withdraw) 7)
(funcall (funcall a2 'deposit) 7)

(funcall ( funcall (make-account 1100) 'withdraw) 1)
(eq a1 a2)

; hybrid : still does not work.
(defun make-account3 (balance)
  (defun deposit (balance)
    (lambda (amount)
      (progn
	(setq balance (+ balance amount))
	balance
	)
      ))

  (defun withdraw (balance)
    (lambda (amount)
      (progn
	(setq balance (- balance amount))
	balance
	)
      )
    )
  (lambda (m)
    (cond ( (string= m 'withdraw) (withdraw balance))
	  ( (string= m 'deposit) (deposit balance))
	  ( t "make-account : Unknown method requested") )
    )
  )

(setq b1 (make-account3 100))
(funcall (funcall b1 'withdraw) 7)
(setq b2 (make-account3 1001))
(funcall (funcall b2 'withdraw) 7)
