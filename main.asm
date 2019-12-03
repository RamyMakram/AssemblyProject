INCLUDE Irvine32FCIS.inc ;DO NOT CHANGE THIS LINE

;###################################################################################;#
;							AUTOGRADER RELATED .DATA								;#
;				DO NOT MODIFY, DELETE NOR ADD ANY LINE HERE							;#
;###################################################################################;#
.data																				;#
																					;#
	prmpt byte "Please enter question number 1, 2, 3, 4, 5, 6, 7 or enter 0 to exit:", 0		;#
	wrongChoice byte "Please enter a valid question number!", 0						;#
	tmpstr byte 5 dup(?), 0															;#
;###################################################################################;#
																					
;#######################################################							
;				STUDENTS  .DATA	SECTION     		   #							
;		   THIS SECTION MADE FOR STUDENTS' DATA        #							
;      YOU CAN MODIFY, ADD OR EDIT TO THIS SECTION     #							
;#######################################################							
																					
.data																				
;#########################Q1 DATA##############################	
EnterEq byte "Enter Equation To Solve: ",0
Equation byte 35 dup(?)
temp byte '15'
;#########################Q1 DATA##############################	
																					
;#########################Q2 DATA##############################	
;#########################Q2 DATA##############################		

;#########################Q3 DATA##############################	
;#########################Q3 DATA##############################		

;#########################Q4 DATA##############################	
;#########################Q4 DATA##############################		

;#########################Q5 DATA##############################	
;#########################Q5 DATA##############################

;#########################Q6 DATA##############################	
;#########################Q6 DATA##############################		
													
;#########################Q7 DATA##############################	
;#########################Q7 DATA##############################		
													
														
														
.code													
														
;#######################################################
;#DO NOT MODIFY, DELETE NOR ADD ANY LINE IN THIS METHOD#
;#######################################################
MAIN PROC											  ;#
	PROGLOOP:										  ;#
		MOV EDX, OFFSET PRMPT						  ;#
		CALL WRITESTRING							  ;#
		CALL CRLF									  ;#
		CALL READINT								  ;#
		CMP EAX, 0									  ;#
		JE FIN										  ;#
													  ;#
		CMP EAX, 1									  ;#
		JNE _Q2										  ;#
		CALL Q1										  ;#
		JMP CONT									  ;#
													  ;#
		_Q2:										  ;#
		CMP EAX, 2									  ;#
		JNE _Q3									      ;#
		CALL Q2										  ;#
		JMP CONT									  ;#
													  ;#
		_Q3:										  ;#
		CMP EAX, 3									  ;#
		JNE _Q4										  ;#
		CALL Q3										  ;#
		JMP CONT									  ;#
													  ;#
		_Q4:										  ;#
		CMP EAX, 4									  ;#
		JNE _Q5										  ;#
		CALL Q4										  ;#
		JMP CONT									  ;#
													  ;#
		_Q5:										  ;#
		CMP EAX, 5									  ;#
		JNE _Q6 									  ;#
		CALL Q5										  ;#
		JMP CONT									  ;#
													  ;#
		_Q6:										  ;#
		CMP EAX, 6									  ;#
		JNE _Q7										  ;#
		CALL Q6										  ;#
		JMP CONT									  ;#
													  ;#
		_Q7:										  ;#
		CMP EAX, 7									  ;#
		JNE WRONG									  ;#
		CALL Q7										  ;#
		JMP CONT									  ;#
													  ;#
		WRONG:										  ;#
		MOV EDX, OFFSET wrongChoice					  ;#
		CALL WRITESTRING							  ;#
		CALL CRLF									  ;#
													  ;#
		CONT:										  ;#
		JMP PROGLOOP								  ;#
													  ;#
		FIN:										  ;#
													  ;#
	EXIT											  ;#
MAIN ENDP											  ;#
;#######################################################

;
;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question one procedure here
;----------------------------------------------------------
Q1 PROC

mov edx,offset EnterEq
call writestring
mov ecx,35
mov edx,offset Equation
call readstring
mov ecx,eax
mov edx,0
mov ebx,0
looop:

    movzx eax, Equation [edx]   ; Get the current character
    
    cmp eax, 48             ; Anything less than 0 is invalid
    jl skip
    
    cmp eax, 57             ; Anything greater than 9 is invalid
    jg skip
     
    sub eax, 48             ; Convert from ASCII to decimal 
    imul ebx, 10            ; Multiply total by 10
    add ebx, eax            ; Add current digit to total
    
skip:
inc edx   

loop looop

 
mov edx,offset Equation
call writestring
call crlf

mov edx,offset Equation
mov al,[edx]
add al,[edx+1]
mov bl,2
mul bl
call writechar
call crlf

RET
Q1 ENDP


;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question two procedure here
;----------------------------------------------------------
Q2 PROC
	CALL PANIC
		RET
Q2 ENDP

;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question three procedure here
;----------------------------------------------------------
Q3 PROC
	CALL PANIC
	RET
Q3 ENDP


;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question four procedure here
;----------------------------------------------------------
Q4 PROC
CALL PANIC
RET
Q4 ENDP

;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question five procedure here
;----------------------------------------------------------
Q5 PROC
	CALL PANIC

	RET
Q5 ENDP

;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question six procedure here
;----------------------------------------------------------
Q6 PROC
	CALL PANIC
	RET
Q6 ENDP

;----------------------------------------------------------
;DO NOT CHANGE THE FUNCTION NAME
;
; Student's procedure
; Remove Call Panic
; Question seven procedure here
;----------------------------------------------------------
Q7 PROC
CALL PANIC
	RET
Q7 ENDP

END MAIN