#lang scheme
; ---------------------------------------------
; DO NOT REMOVE OR CHANGE ANYTHING UNTIL LINE 26
; ---------------------------------------------

; zipcodes.scm contains all the US zipcodes.
; This file must be in the same folder as hw2.scm file.
; You should not modify this file. Your code
; should work for other instances of this file.
(require "zipcodes.scm")

; Helper function
(define (mydisplay value)
	(display value)
	(newline)
)

; Helper function
(define (line func)
        (display "--------- ")
        (display func)
        (display " ------------")
        (newline)
)

; Helper Function
(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))
  )

)

; Helper Function
(define (maxelt lst)
  (if (= (length lst) 1)
      (car lst)
      (max (car lst) (maxelt (cdr lst)))
  )
)

; Helper Function
(define (minelt lst)
  (if (= (length lst) 1)
      (car lst)
      (min (car lst) (minelt (cdr lst)))
  )
)

; Helper Function
(define (product elm lst)
  (if (equal? lst '())
      '()
      (cons (list elm (car lst)) (product elm (cdr lst)))
  )
)

; Helper Function
(define (getPlacesFromState state zips)
  (if (equal? zips '())
      '()
      (if (equal? state (caddar zips))
          (cons (cadar zips) (getPlacesFromState state (cdr zips)))
          (getPlacesFromState state (cdr zips))
      )
  )
)

; Helper Function
(define (removeElement elm lst)
  (if (equal? lst '())
      '()
      (if (equal? elm (car lst))
          (removeElement elm (cdr lst))
          (cons (car lst) (removeElement elm (cdr lst)))
          )
      )
)

; Helper Function
(define (getAllMatches elm lst)
  (if (equal? lst '())
      '()
      (if (equal? elm (car lst))
          (list elm)
          (getAllMatches elm (cdr lst))
      )
  )
)

; Helper Function
(define (getAllListMatches lst1 lst2)
  (if (equal? lst1 '())
      '()
      (append (getAllMatches (car lst1) lst2) (getAllListMatches (removeElement (car lst1) lst1) lst2))
  )
)

; Helper Function
(define (filterList2 lst pred)
  (if (equal? lst '())
      '()
      (if (pred (car lst))
          (cons (car lst) (filterList2 (cdr lst) pred))
          (filterList2 (cdr lst) pred)
      )
  )
)

; ================ Solve the following functions ===================
; Return a list with only the negatives items
(define (negatives lst)
	(cond
          ((equal? lst '()) '())
          ((> 0 (car lst)) (cons (car lst) (negatives (cdr lst))))
          (else (negatives (cdr lst)))
          )
)

(line "negatives")
(mydisplay (negatives '()))  ; -> ()
(mydisplay (negatives '(-1)))  ; -> (-1)
(mydisplay (negatives '(-1 1 2 3 4 -4 5)))  ; -> (-1 -4)
(mydisplay (negatives '(1 1 2 3 4 4 5)))  ; -> ()
(line "negatives")
; ---------------------------------------------

; Returns true if the two lists have identical structure
; in terms of how many elements and nested lists they have in the same order
(define (struct lst1 lst2)
	(cond
          ((not (boolean=? (equal? lst1 '()) (equal? lst2 '()))) #f)
          ((equal? lst1 '()) #t)
          ((and (not (list? lst1)) (not (list? lst2))) #t)
          ((not (boolean=? (list? lst1) (list? lst2))) #f)
          (else (and (struct (car lst1) (car lst2)) (struct (cdr lst1) (cdr lst2))))
          )
)

(line "struct")
(mydisplay (struct '(a b c (c a b)) '(1 2 3 (a b c))))  ; -> #t
(mydisplay (struct '(a b c d (c a b)) '(1 2 3 (a b c))))  ; -> #f
(mydisplay (struct '(a b c (c a b)) '(1 2 3 (a b c) 0)))  ; -> #f
(line "struct")
; ---------------------------------------------

; Returns a list of two numeric values. The first is the smallest
; in the list and the second is the largest in the list. 
; lst -- contains numeric values, and length is >= 1.
(define (minAndMax lst)
	(list (minelt lst) (maxelt lst))
)

(line "minAndMax")
(mydisplay (minAndMax '(1 2 -3 4 2)))  ; -> (-3 4)
(mydisplay (minAndMax '(1)))  ; -> (1 1)
(line "minAndMax")
; ---------------------------------------------

; Returns a list identical to the first list, while having all elements
; that are inside nested loops taken out. So we want to flatten all elements and have
; them all in a single list. For example '(a (a a) a))) should become (a a a a)
(define (flatten lst)
	(cond
          ((equal? lst '()) '())
          ((list? (car lst)) (append (flatten (car lst)) (flatten (cdr lst))))
          (else (cons (car lst) (flatten (cdr lst))))
          )
)

(line "flatten")
(mydisplay (flatten '(a b c)))  ; -> (a b c)
(mydisplay (flatten '(a (a a) a)))  ; -> (a a a a)
(mydisplay (flatten '((a b) (c (d) e) f)))  ; -> (a b c d e f)
(line "flatten")
; ---------------------------------------------

; The paramters are two lists. The result should contain the cross product
; between the two lists: 
; The inputs '(1 2) and '(a b c) should return a single list:
; ((1 a) (1 b) (1 c) (2 a) (2 b) (2 c))
; lst1 & lst2 -- two flat lists.
(define (crossproduct lst1 lst2)
  (if (equal? lst1 '())
      '()
      (append (product (car lst1) lst2) (crossproduct (cdr lst1) lst2))
  )
)

(line "crossproduct")
(mydisplay (crossproduct '(1 2) '(a b c)))
(line "crossproduct")
; ---------------------------------------------

; Returns the first latitude and longitude of a particular zip code.
; if there are multiple latitude and longitude pairs for the same zip code,
; the function should only return the first pair. e.g. (53.3628 -167.5107)
; zipcode -- 5 digit integer
; zips -- the zipcode DB- You MUST pass the 'zipcodes' function
; from the 'zipcodes.scm' file for this. You can just call 'zipcodes' directly
; as shown in the sample example
(define (getLatLon zipcode zips)
	(if (equal? zips '())
            '()
            (if (= zipcode (caar zips))
                (list (cadr (cdddar zips)) (caddr (cdddar zips)))
                (getLatLon zipcode (cdr zips))
            )
        )
)

(line "getLatLon")
(mydisplay (getLatLon 45056 zipcodes))
(line "getLatLon")
; ---------------------------------------------

; Returns a list of all the place names common to two states.
; placeName -- is the text corresponding to the name of the place
; zips -- the zipcode DB
(define (getCommonPlaces state1 state2 zips)
  (define places1 (getPlacesFromState state1 zips))
  (define places2 (getPlacesFromState state2 zips))
  (getAllListMatches places1 places2)
)

(line "getCommonPlaces")
(mydisplay (getCommonPlaces "OH" "MI" zipcodes))
(line "getCommonPlaces")
; ---------------------------------------------

; #### Only for Graduate Students ####
; Returns a list of all the place names common to a set of states.
; states -- is list of state names
; zips -- the zipcode DB
(define (getCommonPlaces2 states zips)
	'("Oxford" "Franklin")
)

(line "getCommonPlaces2")
(mydisplay (getCommonPlaces2 '("OH" "MI" "PA") zipcodes))
(line "getCommonPlaces2")
; ---------------------------------------------

; Returns the number of zipcode entries for a particular state.
; state -- state
; zips -- zipcode DB
(define (zipCount state zips)
  (if (equal? zips '())
      0
      (if (equal? state (caddar zips))
          (+ 1 (zipCount state (cdr zips)))
          (zipCount state (cdr zips))
      )
  )
)

(line "zipCount")
(mydisplay (zipCount "OH" zipcodes))
(line "zipCount")
; ---------------------------------------------

; #### Only for Graduate Students ####
; Returns the distance between two zip codes in "meters".
; Use lat/lon. Do some research to compute this.
; You can find some info here: https://www.movable-type.co.uk/scripts/latlong.html
; zip1 & zip2 -- the two zip codes in question.
; zips -- zipcode DB
(define (getDistanceBetweenZipCodes zip1 zip2 zips)
	0
)

(line "getDistanceBetweenZipCodes")
(mydisplay (getDistanceBetweenZipCodes 45056 48122 zipcodes))
(line "getDistanceBetweenZipCodes")
; ---------------------------------------------

; Some sample predicates
(define (POS? x) (> x 0))
(define (NEG? x) (< x 0))
(define (LARGE? x) (>= (abs x) 10))
(define (SMALL? x) (not (LARGE? x)))

; Returns a list of items that satisfy a set of predicates.
; For example (filterList '(1 2 3 4 100) '(EVEN?)) should return the even numbers (2 4 100)
; (filterList '(1 2 3 4 100) '(EVEN? SMALL?)) should return (2 4)
; lst -- flat list of items
; filters -- list of predicates to apply to the individual elements

(define (filterList lst filters)
  (if (equal? filters '())
      lst
      (filterList (filterList2 lst (car filters)) (cdr filters))
  )
)

(line "filterList")
(mydisplay (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS?)))
(mydisplay (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS? even?)))
(mydisplay (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS? even? LARGE?)))
(line "filterList")
; ---------------------------------------------

