;;; char_e_char_t.S		02/12/2016

CPU_FREQ = 16000000
TICKS_PER_SEC = CPU_FREQ / (256 * 1024)

DECISION_LIMIT = TICKS_PER_SEC / 5 ;;200 ms
TIMEOUT = 2 * TICKS_PER_SEC / 5 ;;400ms

#define__SFR_OFFEST 0
#include <avr/io.h>
#include "characterDefinitions.S"

;;Button connected to pin 8 port B pin 0
BUTTON = 0

	.section .text

	;;USER CODE START

	.global main

main:

	;;PORT OUTPUT SETUP
	ldi r16, SEG_7_OUT
	out DDRD, r16
	
	;;Set up port for button DDRB 0 is automatically an input
	sbi PORTD, BUTTON 		;;Released button is 1, depressed is 0
	
	
	
	;;setup the timer
	clr r16,
	sts TCCR1A, r16
	
	ldi r16, TIMEOUT
	sts OCR1AH, r16
	
	clr r16
	sts OCR1AL, r16
	;;END
	
	
	
	
	
	;;enable input capture intterupt
	ldi r16, _BV(ICIE1) | _BV(OCIE1A)
	sts TIMSK1, r16
	
	;;noise canceller
	ldi r16, _BV(ICNC1) | _BV(CS12) | _BV(CS10) | _BV(WGM12)
	sts TCCR1B, r16
	
	
	
	
	
	clr r19		;;reset overflow flag
	
	sei			;;enable global interrupts
	
	
	
	
	
fourE4: rjmp fourE4		;;do nothing and wait for interrupts to occur
	
	.global timer1_compa_isr
	


timer1_compa_isr:
	push r16
	in r16, SREG 	;;save status register
	push r16

// 	ldi r16, _BV(CHAR_E)
//	out PORTD, r16
	
	;;check if we are waiting for button press or release
	lds r16, TCCR1B
	sbrs r16, ICES1		;;skip if waiting for button release
	rjmp awaiting_press
	


awaiting_release:
	ser 19 	;;use r19 as a flag to indicate that timer overflow is occuring
	rjmp 1f
		
		
		
awaiting_press:
	ldi r16, _BV(BUTTON)
	out PORTD, r16
	

	
1: 	pop r16
	out SREG, r16
	pop r16
	
	reti
	
	
	
	

	
	
timer1_cpt_isr:
	push r8
	
	in r8, SREG
	push r8
	
	
	lds r8, ICR1L
	lds r8, ICR1H
	
	push r17
	
	or r17, r8
	
	mov r17,r19
	or r17,r8
	
	breq bounce
	
	
	clr r17
	sts TCNT1H, r17
	sts TCNT1L, r17
	
	
	;;check if we are looking for postitive or negative edges
	lds r17, TCCR1B
	sbrs r17, ICES1
	
	rjmp pressed
	
	
	rcall released
	
	andi r17, ~(_BV(ICES1))
	
	rjmp end_isr
	
	
	
pressed:
	;;call depressed
	ori r17, _BV(ICES1)
	
	
end_isr:
	sts TCCR1B, r17
	

debounce:
	pop r17
	pop r8
	out SREG, r8
	pop r8
	
	reti

	
released:
	push r16 
	tst r19
	
	brne long_press
	
	
	ldi r16, DECISION_LIMIT
	cp r8, r16
	brcs short_press
	

long_press:
	ldi r16, _BV(CHAR_T) | BV_(BUTTON)
	rjmp 1f
	
short_press:
	ldi r16, _BV(CHAR_E) | BV_(BUTTON)
	
1:	out PORTD, r16

	pop r16
	clr r19
	ret
