INCLUDE Irvine32FCIS.inc ;DO NOT CHANGE THIS LINE

;###################################################################################;#
.data																				;#
																					;#
	prmpt byte "	Please enter question number 1, 2, 3, or enter 0 to exit:", 0		;#
	wrongChoice byte "Please enter a valid question number!", 0		                ;#
	intro byte "							     Welcome to Drivative solver                      ",0              
	instructions byte "	Before get started follow the following instructions :",0    
	X_inst byte "					- Make variable Capital Example : X ",0                           
	pow_inst byte "					- write ( ^ ) to explain power",0                                
	int_inst byte "					- Coofficients & powers should be integers only",0               
	Pynomial byte "					1- Pynomial Equation",0                           
	trigo byte "					2- Trigyomitric Equation",0                               
	fract byte "					3- Fractional Equation",0                
																					;#
	tmpstr byte 5 dup(?), 0															;#
;###################################################################################;#
																																										
.data	
																
;#########################Q1 DATA##############################	
EnterEq byte "Enter Equation To Solve: ",0
Equation byte 35 dup(-1)
Co dword 35 dup(-1)
Power dword 35 dup(-1)
Sign dword 35 dup(?)
Val byte 0
PowerFlag byte 0
LenghtOfEnterd dword 0
temp dword 0
ReadedX dword 0
NumOfTerms dword 0
offsetOfEq dword 0
;#########################Q1 DATA##############################	
																					
;#########################Q2 DATA##############################	

;#########################Q2 DATA##############################		

;#########################Q3 DATA##############################	
bast byte 35 dup(-1)
makam byte 35 dup(-1)
;#########################Q3 DATA##############################		
													
														
														
.code													
														
;#######################################################
MAIN PROC									  ;#
mov edx,offset intro								  ;#
		call writestring						      ;#
		call crlf									  ;#
		call crlf									  ;#
		call crlf									  ;#
		mov edx,offset instructions					  ;#
		call writestring							  ;#
		call crlf									  ;#
		call crlf									  ;#
		mov edx,offset X_inst						  ;#
		call writestring							  ;#
		call crlf									  ;#
		mov edx,offset pow_inst						  ;#
		call writestring							  ;#
		call crlf									  ;#
		mov edx,offset int_inst						  ;#
		call writestring							  ;#
		call crlf									  ;#
		call crlf									  ;#
		call crlf									  ;#
		mov edx,offset 	Pynomial					  ;#
		call writestring							  ;#
		call crlf									  ;#
		mov edx,offset trigo						  ;#
		call writestring							  ;#
		call crlf									  ;#
		mov edx,offset fract						  ;#
		call writestring							  ;#
		call crlf									  ;#
		call crlf									  ;#
		call crlf
	PROGLOOP:
		mov esi,0
		mov ecx,35
		loopp:
			mov Co[esi],-1
			mov Power[esi],-1
			mov Sign[esi],-1
			add esi,4
		loop loopp												  ;#
		call crlf									  ;#
		MOV EDX, OFFSET PRMPT						  ;#
		CALL WRITESTRING							  ;#
		CALL CRLF									  ;#
		CALL READINT								  ;#
		CMP EAX, 0									  ;#
		JE FIN										  ;#
													  ;#
		CMP EAX, 1									  ;#
		JNE _Q2										  ;#
		mov edx,offset EnterEq
		call writestring
		mov ecx,35
		mov edx,offset Equation
		call readstring
		call Q1		
		JMP CONT								  ;#
													  ;#
		_Q2:										  ;#
		CMP EAX, 2									  ;#
		JNE _Q3									      ;#
		mov edx,offset EnterEq
		call writestring
		CALL Q2										  ;#
		JMP CONT									  ;#
													  ;#
		_Q3:										  ;#
		CMP EAX, 3									  ;#	
		mov edx,offset EnterEq
		call writestring							  ;#
		CALL Q3										  ;#
		JMP CONT									  ;#
													  ;#
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
;----------------------------------------------------------
Q1 PROC





	mov NumOfTerms,0
	inc eax
	mov LenghtOfEnterd,eax
	mov ecx, eax
	mov edx,0
	mov ebx,0 ;total Calc
	mov esi, offset Co
	mov edi,offset Power
	mov ebp,offset Sign
	mov PowerFlag,0 ;flag of power
	looop:

		movzx eax, Equation[edx]   ; Get the current character
		cmp eax,45 ; value is -
		je skip
		cmp eax,43 ; value is +
		je skip
		cmp ecx,LenghtOfEnterd
		je AddFirstPlus
		jmp Action

	 AddFirstPlus:
		call AddFirstPlusProc

	Action:
		movzx eax, Equation[edx]
		cmp eax,88 ; value is X
		je ChangeReadedX
		cmp eax,94 ; value is ^
		je ChanePower
		cmp ecx,1 ;last elem
		je AssignLastElem
		call CalcAppend
		jmp continue

	ChangeReadedX:
		mov ReadedX,1
		jmp assignCof

	ChanePower:
		mov PowerFlag,1 ;add power flag
		jmp continue

	AssignLastElem:
		cmp ReadedX,1 ;check power flag
		je assignPower
		jmp assignCof

	skip:
		mov [ebp],eax
		add ebp,4
		call CheckFreeVar
		cmp PowerFlag,1 ;check power flag
		je assignPower
		jmp continue

	assignCof:
		call AssignCoffient
		cmp eax,94 ; value is ^
		je continue

	assignPower:
		call AssignPowerProc

	continue:
		inc edx
		dec ecx
		cmp ecx,0
		jne looop    


	;###########################Der##################################
	mov esi, offset Co
	mov edi,offset Power
	mov ecx,NumOfTerms
	loop2:
		mov eax,[esi]
		mov ebx,[edi]
		cmp ebx,-1
		je LastElementIsNum
		imul eax,ebx
		mov [esi],eax
		dec ebx
		mov [edi],ebx
		jmp Contloop2

	LastElementIsNum:
		mov eax,0
		mov [esi],eax

	Contloop2:
		add esi,4
		add edi,4
	loop loop2
	;###########################Print##################################
	mov esi, offset Co
	mov edi,offset Power
	mov ebx,offset Sign
	mov ecx,NumOfTerms
	loop3:

		cmp ecx,NumOfTerms
		je PrintFirstSign
		jmp PrintSign

	PrintFirstSign:
		mov eax,[esi]
		cmp eax,0
		je cont
		mov edx,45 
		cmp [ebx],edx ;cmp mince
		je PrintMince
		add ebx,4
		jmp Actions2

	PrintMince:
		mov al,'-'
		call writechar
		jmp Actions2

	PrintSign:
		mov eax,[esi]
		cmp eax,0
		je cont
		mov al,[ebx]
		call writechar
		add ebx,4

	Actions2:
		mov eax,[esi]
		cmp eax,0
		je cont
		call writedec
		mov eax,[edi]
		cmp eax,0
		jle cont ;print only Co
		cmp eax,1
		je PrintX ;print only X
		jmp PrintAll

	PrintX:
		mov al,'X'
		call writechar
		jmp cont

	PrintAll:
		mov al,'X'
		call writechar
		mov al,'^'
		call writechar
		mov eax,[edi]
		call writedec

	cont:
		add esi,4
		add edi,4

	loop loop3

;###########################CalcAppend##################################
CalcAppend PROC
	movzx eax, Equation[edx]
    sub eax, 48             ; Convert from ASCII to decimal 
    imul ebx, 10            ; Multiply total by 10
    add ebx, eax            ; Add current digit to total
		RET
CalcAppend ENDP

AssignCoffient PROC
	inc NumOfTerms
	mov [esi],ebx
	mov ebx,0
	add esi,4
	movzx eax, Equation[edx+1]
		RET
AssignCoffient ENDP

AssignPowerProc PROC
	cmp PowerFlag,1 ;check power flag
	je TherePower
	cmp ReadedX,0
	je NoX
	mov ebx,1
	mov [edi],ebx
	jmp continue
TherePower:
	mov [edi],ebx
	jmp continue
NoX:
	mov ebx,-1
	mov [edi],ebx
continue:
	mov ReadedX,0
	mov PowerFlag,0 ;remove flag
	mov ebx,0
	add edi,4
		RET
AssignPowerProc ENDP

AddFirstPlusProc PROC
	mov eax,43
	mov [ebp],eax
	add ebp,4
	movzx eax, Equation[edx]
	CMP EAX,88 ;THERE X
	JE FirstIsX
	jmp Cont
	mov ebx,0
FirstIsX:
	mov ebx,1
	jmp Cont
Cont:
	movzx eax, Equation[edx]
RET
AddFirstPlusProc ENDP

CheckFreeVar PROC
	movzx eax, Equation[edx+1]
	CMP EAX,88 ;THERE X
	JE FirstIsX
	jmp Cont
	mov ebx,0
FirstIsX:
	mov ebx,1
	jmp Cont
Cont:
	movzx eax, Equation[edx]
RET
CheckFreeVar ENDP	




call crlf
RET
Q1 ENDP


;----------------------------------------------------------
;----------------------------------------------------------
Q2 PROC
Call Panic
call crlf
		RET
Q2 ENDP 

;----------------------------------------------------------
;----------------------------------------------------------

Q3 PROC
		
Q3 ENDP

;----------------------------------------------------------
;----------------------------------------------------------

END MAIN