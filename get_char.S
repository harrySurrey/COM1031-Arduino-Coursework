;;;  get_digit.s 25/11/12 (A.Gruning)J.Y.Clark, C. Cheong
;;;  This lab material and corresponding solutions are 
;;;  released under the Creative Commons Share-Alike 
;;;  Non-Commercial Licence at 
;;;  http://creativecommons.org/licenses/by-nc-sa/3.0/
;;;  (C) Andre Gruning, 2011. Developed for COM1031 in 2011.
;;;  (C) Jonathan Clark. 2012. Adapted for COM1031 in 2012.
;;;  (C) Clive Cheong. 2013. Adapted for COM1031 in 2013.
;;;	REFERENCES:
;;;	[ATmega]: General 8-bit Atmel Microcontroller document 
;;;  
;;; 
;;;  [ATmega328p]: Specific ATmega328p document (quite large!)
;;;  downloadable from
;;;  www.atmel.com/Images/doc7810.pdf
;;;  [AVR]: Instruction Set Manual
;;;  downloadable from
;;;  www.atmel.com/Images/doc0856.pdf
;;;

;;; import all symbol definitions for the seven segment display.
#include "char_definition.S"


;;; This subroutine converts a number from 0x0 to 0x7 to its digit
;;; representation on the 7-segment-display  

;;; Input:
;;; r24: hexadecimal number to display
;;; 
;;; Output:
;;; r24: 7-segment representation of the digit
;;;

	.global get_char

get_char:

	push r30		; save Z reg low
	push r31		; save Z reg hi

	andi r24, 0x25		; make sure r24 is between 0 and 62

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

char_table:
	.byte CHAR_null, CHAR_E, CHAR_T, CHAR_I, CHAR_N, CHAR_A, CHAR_M, CHAR_S, CHAR_D, CHAR_R, CHAR_G, CHAR_U, CHAR_K, CHAR_W, CHAR_O, CHAR_H, CHAR_B, CHAR_L, CHAR_Z, CHAR_F, CHAR_C, CHAR_P, CHAR_e, CHAR_V, CHAR_X, CHAR_e, CHAR_Q, CHAR_e, CHAR_Y, CHAR_J, CHAR_e, CHAR_5, CHAR_6, CHAR_e, CHAR_7, CHAR_e, CHAR_e, CHAR_e, CHAR_8, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_9, CHAR_4, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_e, CHAR_3, CHAR_e, CHAR_e, CHAR_e, CHAR_2, CHAR_e, CHAR_1, CHAR_0 



	
