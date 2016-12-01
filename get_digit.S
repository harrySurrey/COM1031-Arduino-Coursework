;;;  get_digit.S 03/12/12 (A.Gruning)J.Y.Clark, C. Cheong
;;;  This lab material and corresponding solutions are 
;;;  released under the Creative Commons Share-Alike 
;;;  Non-Commercial Licence at 
;;;  http://creativecommons.org/licenses/by-nc-sa/3.0/
;;;  (C) Andre Gruning, 2011. Developed for COM1031 in 2011.
;;;  (C) Jonathan Clark. 2012. Adapted for COM1031 in 2012.
;;;  (C) Clive Cheong. 2013. Adapted for COM1031 in 2013.
;;;	REFERENCES:
;;;	[ATmega]: General 8-bit Atmel Microcontroller document 
;;;  downloadable from
;;;  www.atmel.com/dyn/resources/prod_documents/8271S.pdf
;;;  [ATmega328p]: Specific ATmega328p document (quite large!)
;;;  downloadable from
;;;  www.atmel.com/Images/doc7810.pdf
;;;  [AVR]: Instruction Set Manual
;;;  downloadable from
;;;  www.atmel.com/Images/doc0856.pdf
;;;

;;; import all symbol definitions for the seven segment display.
#include "7segment.S"


;;; This subroutine converts a number from 0x0 to 0xF to its digit
;;; representation on the 7-segment-display  

;;; Input:
;;; r24: hexadecimal number to display
;;; 
;;; Output:
;;; r24: 7-segment representation of the digit
;;;

	.global get_digit

get_digit:

	push r30		; save Z reg low
	push r31		; save Z reg hi

	andi r24, 0x0F		; make sure r24 is between 0 and 0xF

	ldi r30, lo8(digit_table) ; make Z point to the table with the digits.
	ldi r31, hi8(digit_table) 
	
	add r30, r24	       ; the number in r24 is the offset into the table
	brcc 1f		       ; if no overflow from Z low, continue at 1
	inc r31		       ; else add overflow to Z high byte
	
1:	
	lpm r24, Z		; load seven seg representation from the table (in prog memory)
	
	pop r31			; restore used registers.
	pop r30

	ret			; return from subroutine


	
;;; This table stores the 7-segment representations for the digits
;;; from 0x0 to 0xF in program memory (that is alright as it does not
;;; need change):

digit_table:
	.byte CHAR_0, CHAR_1, CHAR_2, CHAR_3, CHAR_4, CHAR_5, CHAR_6, CHAR_7
	.byte CHAR_8, CHAR_9, CHAR_A, CHAR_B, CHAR_C, CHAR_D, CHAR_E, CHAR_F


	