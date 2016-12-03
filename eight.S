;;;  eight.s (new version) 03/12/12 (A.Gruning)J.Y.Clark, C. Cheong
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

;;; Program counts from 0 to F with 1s delays and displays the count on a seven segement display.  

;;; include all port definitions
#define __SFR_OFFSET 0
#include <avr/io.h>

;;; include all symbol definitions for the seven segement display:
#include "char_definition.S"

	.global main
	
main:
	ldi r24, ALL_SEGS
	out DDRD, r24 		; make pins of PORTD output (except pin 0)


	clr r24			; set counter to zero.

loop:	push r24		; save counter

	//lsl r24		; left shift to get every second value.
	//inc r24		; to get the even digits only
	rcall get_char		; convert counter to digit representation
	out PORTD, r24		; display digit

	ldi r24,1		
	rcall delay		; delay for 1s

	pop r24			; restore counter value

	inc r24			; advance counter
	rjmp loop
