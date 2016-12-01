;;;  delay.s 21/11/12 (A.Gruning)J.Y.Clark, C. Cheong
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

;;; This subroutine delays execution by the number of seconds stored in r24.
;;; 
;;; It uses three nested loops and counts down three registers.
;;; Check in the instruction set manual [AVR] 
;;; how dec r1 influences the z flag in SREG and how brne reacts to that.
;;; Check with [AVR] how many clock ticks an instruction takes.


	.global delay
delay:

	push r24
	push r17
	push r2
	push r1
	
outermost_delay:

	ldi r17, 82		; 1000ms delay, see below

outer_delay:
	clr r1 			
middle_delay:
	clr r2			
inner_delay:		   	
	dec r2			; 1 clock tick
	brne inner_delay	; 2 clock ticks when z!=0, 1 tick when z=0.

	dec r1			; when this line is reached, about
				; 256*3 = 768 ticks have been consumed since inner_delay.
	brne middle_delay	; 

	dec r17                 ; when this line is reache, about
				; 256*256*3 = 196608 ticks have been
				; consumed since middle delay.
	brne outer_delay	
	;; moving past brne outer_delay we have consumed about
	;; 82*196608 = 16.121.856 clock ticks. As the CPU is running at
	;; 16MHz = 16.000.000 clock ticks / s we have consumed about
	;; 1s of time.

	dec r24
	brne outermost_delay

	pop r1
	pop r2
	pop r17
	pop r24
	
	ret