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
Co byte 35 dup(?)
Power byte 35 dup(?)
PowerFlag byte 0
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
mov esi, offset Co
mov edi,offset Power
mov PowerFlag,0 ;flag of power
looop:

    movzx eax, Equation[edx]   ; Get the current character
    
	cmp eax,45 ; value is -
	je skip
	cmp eax,43 ; value is +
	je skip
	cmp eax,43 ; value is X
	je assignCof
	cmp eax,94 ; value is ^
	je ChanePower

     
    sub eax, 48             ; Convert from ASCII to decimal 
    imul ebx, 10            ; Multiply total by 10
    add ebx, eax            ; Add current digit to total

ChanePower:
	mov PowerFlag,1 ;add power flag
	jmp continue

skip:
	cmp PowerFlag,1 ;check power flag
	je assignPower
	jmp continue

assignCof:
    mov [esi],ebx
	mov ebx,0
	inc esi
	jmp continue

assignPower:
	mov [edi],ebx
	mov ebx,0
	mov PowerFlag,0 ;remove flag
	inc edi
	jmp continue

continue:
	inc edx   
loop looop

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