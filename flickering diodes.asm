.include "m16def.inc" //the file includes names of registers e.g. DDRC

PG: //the beginning of the PG subprogram

LDI R16, 12		; (LoaD Into) load 12 into R16

MOV R0, R16		; copy the value from R16 to R0
ADD R0, R17		; Add the value of R17 to R0
ROL R0			  ; Rotate Left trough Carry - move all the bits to the left
              ; the most significant bit (MSB) becomes the least significant bit (LSB)
LSL R0			  ; Move bits to the left (increase the value)
ROR R0			  ; Move bits to the right and move the LSB to the beginning
LSR R0			  ; Move bits to the right, LSB becomes the MSB
ASR R0			  ; Move bits to the right, keep MSB

              ; 0 � diode turned on, 1 � diode turned off
              
LDI R16, 0x55	    ; Port C: R16...R23, Turn on green diodes 10101010
OUT DDRC, R16     ; Send value from register R16 to port DDRC

CALL SUBPROG      ; call time delay

LDI R16, 0xAA	    ; Turn on green diodes 01010101
OUT PORTC, R16

CALL SUBPROG      ; call time delay

JMP PG			      ; jump to the beginning (the program is looped)



SUBPROG:          ; definition of a delaying subprogram
                  ; 3 nested loops will cause a big delay so that the changing colours of the diodes can be noticeable

LDI R17,0xFF		  ; load the biggest value into R17: 11111111 (255 decimal)

	P1: 		        ; suprogram P1 will loop for 255 times
	LDI R18, 0x0F	  ; The value of R18 will control the loop P2

		P2: 			    ; subprogram P2
		LDI R19,0xFF  ; Value of R19 will control the loop P3

			P3: 		    ; subprogram P3                         
			  DEC R19   ; Decrease the value of R19 by 1
			  BRNE P3   ; BRanch if Not Equal, if R19 != 0, go to P3, if R19 == 0, end the loop
        
		DEC R18
		BRNE P2	

	DEC R17
	BRNE P1		
  
RET               ; return to the caller (PG), the end of SUBPROG