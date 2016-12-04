;;;	characterDefinitions.S
;;;	Group 13 COM1031
;;;	This code defines which segments are used as outputs in order to display different characters
;;;	on a seven segment display.

;;;	REFERENCES:
;;;	[ATmega]: General 8-bit Atmel Microcontroller document 
;;;	[Clive Cheong]:	Lab material for COM1031 (Week 8)


#include <avr/io.h> 	;;Includes the appropriate IO definitions for the device		


	;;This defines which pins of port D relate to which lights on the seven segment display
	
	SEG_A = 7		; top
	SEG_B = 1 		; upper right
	SEG_C = 2		; lower right
	SEG_D = 3		; buttom
	SEG_E = 4		; lower left
	SEG_F = 5		; upper right
	SEG_G = 6		; middle


	;; This variable is a mask of all bits used, this will make it easy in other files to initialise these
	;; pins as outputs.
	SEG_7_OUT = _BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G) 


	;; Defined below are the combinations required to represent different characters of 
	;; the alphabet and the digits 0-9.
	
	;; The characters are inverted with the ~ symbol because the seven segment display follows inverse
	;; logic, so a 0 bit would turn that segment ON.
	
	CHAR_e = ~(_BV(SEG_A) | _BV(SEG_D))
	CHAR_0 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
	CHAR_1 = ~(_BV(SEG_B) | _BV(SEG_C))
	CHAR_2 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_G) | _BV(SEG_E) | _BV(SEG_D))
	CHAR_3 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_G))
	CHAR_4 = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_5 = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_6 = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_7 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C))
	CHAR_8 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_9 = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
    
	CHAR_A = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) |_BV(SEG_E) | _BV(SEG_G))
	CHAR_B = ~(_BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
	CHAR_C = ~(_BV(SEG_G) | _BV(SEG_D) | _BV(SEG_E))
	CHAR_D = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_G))
	CHAR_E = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G) | _BV(SEG_D))
	CHAR_F = ~(_BV(SEG_A) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_G = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_H = ~(_BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_I = ~(_BV(SEG_E) | _BV(SEG_F))
    	CHAR_J = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D))
    	CHAR_K = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_L = ~(_BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
    	CHAR_M = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_E) | _BV(SEG_F))
    	CHAR_N = ~(_BV(SEG_C) | _BV(SEG_E) | _BV(SEG_G))
    	CHAR_O = ~(_BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_G))
    	CHAR_P = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_Q = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F))
    	CHAR_R = ~(_BV(SEG_E) | _BV(SEG_G))
    	CHAR_S = ~(_BV(SEG_A) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F))
    	CHAR_T = ~(_BV(SEG_F) | _BV(SEG_E) | _BV(SEG_G))
    	CHAR_U = ~(_BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E))
    	CHAR_V = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F))
    	CHAR_W = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_X = ~(_BV(SEG_B) | _BV(SEG_E) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_Y = ~(_BV(SEG_B) | _BV(SEG_C) | _BV(SEG_D) | _BV(SEG_F) | _BV(SEG_G))
    	CHAR_Z = ~(_BV(SEG_A) | _BV(SEG_B) | _BV(SEG_D) | _BV(SEG_E))
	
