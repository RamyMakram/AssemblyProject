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
Return dword 35 dup(-1)
Val byte 0
PowerFlag byte 0
LenghtOfEnterd dword 0
temp dword 0
ReadedX dword 0
NumOfTerms dword 0
offsetOfEq dword 0
OutPut byte 35 dup(?),0
																					
;#########################Q2 DATA##############################	

TragEquation byte 35 dup(-1)
SizeOFTrag dword 0
Sin byte "Cos(",0
Cos byte "-Sin(",0
Tan byte "Sec^2(",0
EQSize dword 0
ESITemp dword 0
ECXTemp dword 0
;#########################Q3 DATA##############################	
EqDev byte 35 dup(-1)
IsMakam dword 0
bast byte 35 dup(-1)
makam byte 35 dup(-1)
NString dword 0
NBast dword 0
NMakam dword 0
													
														
														
.code													
														
;#######################################################
MAIN PROC									  ;#
		mov edx,offset intro						  ;#
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
		mov edi,0
		loopp:
			mov Co[esi],-1
			mov Power[esi],-1
			mov Return[esi],-1
			mov EqDev[edi],-1
			mov makam[edi],-1
			mov bast[edi],-1
			add esi,4
			inc edi
		loop loopp									  ;#
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
	mov PowerFlag,0 ;flag of power
	looop:

		movzx eax, Equation[edx]   ; Get the current character
		cmp eax,45 ; value is -
		je skip
		cmp eax,43 ; value is +
		je skip
		cmp eax,-1 ; value is +
		je Out2
		cmp ecx,LenghtOfEnterd
		je Check_FirstX
		jmp Action

	Check_FirstX:
		call CheckFirst_X

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
		cmp PowerFlag,1 ;check power flag
		je assignPower
		call CheckFreeVar
		jmp continue

	assignCof:
		call AssignCoffient
		cmp eax,94 ; value is ^
		je continue

	assignPower:
		call AssignPowerProc
		call CheckFreeVar

	continue:
		inc edx
		dec ecx
		cmp ecx,0
		jne looop    

Out2:
mov ecx,0
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
	mov ecx,NumOfTerms
	mov ebp,0
	loop3:

		cmp ecx,NumOfTerms
		je PrintFirstSign
		jmp PrintSign

	PrintFirstSign:
		mov eax,[esi]
		cmp eax,0
		je cont
		call writedec
		call AsignInReturn
		jmp Actions2

	PrintSign:
		mov eax,[esi]
		cmp eax,0
		je cont
		call writeint
		mov eax,43
		call AsignInReturn
		mov eax,[esi]
		call AsignInReturn

	Actions2:
		mov eax,[edi]
		cmp eax,0
		jle cont ;print only Co
		cmp eax,1
		je PrintX ;print only X
		jmp PrintAll

	PrintX:
		mov al,'X'
		call writechar
		mov eax,88
		call AsignInReturn
		jmp cont

	PrintAll:
		mov al,'X'
		call writechar
		mov eax,88
		call AsignInReturn
		mov al,'^'
		call writechar
		mov eax,94
		call AsignInReturn
		mov eax,[edi]
		call writedec

	cont:
		add esi,4
		add edi,4
		dec ecx
		cmp ecx,0
		jne loop3
RET
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

CheckFirst_X PROC
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
CheckFirst_X ENDP

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

AsignInReturn PROC
	mov Return[ebp],eax
	add ebp,4
RET
AsignInReturn ENDP

PrepairToPrint PROC
	mov edx, 0             ; dividend high half = 0.  prefer  xor edx,edx
	mov ebx, 10            ; divisor can be any register or memory
	div ebx ; Divides 1234 by 10.
			; EDX =   4 = 1234 % 10  quotient
			; EAX = 123 = 1234 / 10  remainder
RET
PrepairToPrint ENDP

Q1 ENDP


;----------------------------------------------------------
;----------------------------------------------------------
Q2 PROC
mov ecx,35
mov edx,offset TragEquation
call readstring
mov ecx,eax
mov SizeOFTrag,eax
mov esi,0
LoopQQQ1:

mov al,TragEquation[esi]
cmp al,83
je Sin_Lable
cmp al,67
je Cos_Lable
cmp al,84
je Tan_Lable
cmp al,')'
je ContQ3_
cmp al,'+'
je ContQ3_
cmp al,0
je ContQ3_

Sin_Lable:
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call SinProc
	mov eax,EQSize
	call Q1
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_
Cos_Lable:
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call CosProc
	mov eax,EQSize
	call Q1
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_
Tan_Lable:
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call TanProc
	mov eax,EQSize
	call Q1
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

ContQ3_:
	add eax,0
	inc esi
	dec ecx
	cmp ecx,0
	jne LoopQQQ1 





call crlf
		RET

;########################################################################
SinProc PROC
mov eax,SizeOFTrag
sub eax,4
cmp ecx,eax
jne PrintSignTrag1
jmp Outq1

PrintSignTrag1:
	mov al,'+'
	call writechar

Outq1:
mov EQSize,0
mov edx,offset Sin
call writestring
mov ESITemp,esi
call EmptyArrays
mov esi,ESITemp
mov edi,offset Equation
mov ecx,ECXTemp
lopp1:
	mov al,TragEquation[esi]
	cmp al,')'
	je CaallQ1_1
	call writechar
	mov [edi],al
	inc EQSize
	inc esi
	inc edi
	dec ECXTemp
loop lopp1

CaallQ1_1:
	mov al,')'
	call writechar
	mov al,'*'
	call writechar
	mov eax,EQSize
	mov ESITemp,esi
	mov ECXTemp,ecx
RET
SinProc ENDP

;#######################################################################
CosProc PROC
mov EQSize,0
mov edx,offset Cos
call writestring
mov ESITemp,esi
call EmptyArrays
mov esi,ESITemp
mov edi,offset Equation
mov ecx,ECXTemp
lopp2:
	mov al,TragEquation[esi]
	cmp al,')'
	je CaallQ1_2
	call writechar
	mov [edi],al
	inc EQSize
	inc esi
	inc edi
	dec ECXTemp
loop lopp2

CaallQ1_2:
	mov al,')'
	call writechar
	mov al,'*'
	call writechar
	mov eax,EQSize
	mov ESITemp,esi
	mov ECXTemp,ecx
RET
CosProc ENDP
;################################################################################3
TanProc PROC
mov eax,SizeOFTrag
sub eax,4
cmp ecx,eax
jne PrintSignTrag3
jmp Outq

PrintSignTrag3:
	mov al,'+'
	call writechar

Outq:
mov EQSize,0
mov edx,offset Tan
call writestring
mov ESITemp,esi
call EmptyArrays
mov esi,ESITemp
mov edi,offset Equation
mov ecx,ECXTemp
lopp3:
	mov al,TragEquation[esi]
	cmp al,')'
	je CaallQ1_3
	call writechar
	mov [edi],al
	inc EQSize
	inc esi
	inc edi
	dec ECXTemp
loop lopp3

CaallQ1_3:
	mov al,')'
	call writechar
	mov al,'*'
	call writechar
	mov eax,EQSize
	mov ESITemp,esi
	mov ECXTemp,ecx
RET
TanProc ENDP


Q2 ENDP 
;----------------------------------------------------------
;----------------------------------------------------------

Q3 PROC
mov ecx,35
mov edx, offset EqDev
call readstring
mov ecx, eax 
mov esi,0
mov edi,offset bast
mov ebp,offset makam
mov NBast,0
mov NMakam,0
mov IsMakam,0

loopQQ:
movzx eax,EqDev[esi]
cmp IsMakam,1
je AssignMakam
cmp eax,47
je IsMakamLable
mov [edi],al
inc NBast
inc edi
jmp Continiutesss

IsMakamLable:
	mov IsMakam,1
	jmp Continiutesss

AssignMakam:
	mov [ebp],al
	inc NMakam
	inc ebp

Continiutesss:
	inc esi

loop loopQQ
call EmptyArrays
mov ecx,NBast
mov esi, offset Equation
mov edi, offset bast
loop1QQ:
	mov al,[edi]
	mov [esi],al
	inc edi
	inc esi
loop loop1QQ
mov al,'['
call writechar
mov al,'('
call writechar
mov eax,NBast
call Q1
mov al,')'
call writechar
mov al,'*'
call writechar
mov al,'('
call writechar
mov edi,offset makam
mov ecx,NMakam
loop2QQ:
	mov al,[edi]
	call writechar
	inc edi
loop loop2QQ
mov al,')'
call writechar
mov al,'-'
call writechar
mov al,'('
call writechar

call EmptyArrays
mov ecx,NMakam
mov esi, offset Equation
mov edi, offset makam
loop3QQ:
	mov al,[edi]
	mov [esi],al
	inc edi
	inc esi
loop loop3QQ
mov eax,NMakam
call Q1
mov al,')'
call writechar
mov al,'*'
call writechar
mov al,'('
call writechar
mov edi,offset bast
mov ecx,NBast
loop21QQ:
	mov al,[edi]
	call writechar
	inc edi
loop loop21QQ
mov al,')'
call writechar
mov al,']'
call writechar
mov al,'/'
call writechar
mov al,'('
call writechar
mov edi,offset makam
mov ecx,NMakam
loop5QQ:
	mov al,[edi]
	call writechar
	inc edi
loop loop5QQ
mov al,')'
call writechar
mov al,'^'
call writechar
mov al,'2'
call writechar

Q3 ENDP

EmptyArrays PROC
		mov esi,0
		mov edi,0
		mov ecx,35
		loopp:
			mov Co[esi],-1
			mov Equation[edi],-1
			mov Power[esi],-1
			mov Return[esi],-1
			add esi,4
			inc edi
		loop loopp	
RET
EmptyArrays ENDP

;----------------------------------------------------------
;----------------------------------------------------------

END MAIN