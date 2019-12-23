INCLUDE Irvine32FCIS.inc ;DO NOT CHANGE THIS LINE

;###################################################################################;#
.data																				;#
																					;#
	prmpt byte "	Please enter question number 1, 2, 3, 4, or enter 0 to exit:", 0		;#
	wrongChoice byte "Please enter a valid question number!", 0		                ;#
	intro byte "							     Welcome to Drivative solver                      ",0              
	instructions byte "	Before get started follow the following instructions :",0    
	X_inst byte "					- Make variable Capital Example : X ",0                           
	pow_inst byte "					- write ( ^ ) to explain power",0                                
	int_inst byte "					- Coofficients & powers should be integers only",0               
	Pynomial byte "					1- Pynomial Equation",0                           
	trigo byte "					2- Trigyomitric Equation",0                               
	fract byte "					3- Fractional Equation",0                
	Bonus byte "					4- Bonus Equation",0                
																					;#
	tmpstr byte 5 dup(?), 0															;#
;###################################################################################;#
																																										
.data	
																
;#########################Q1 DATA##############################	
EnterEq byte "Enter Equation To Solve: ",0
Equation byte 70 dup(-1)
Co dword 70 dup(-1)
Power dword 70 dup(-1)
Return dword 70 dup(-1)
Val byte 0
PowerFlag byte 0
LenghtOfEnterd dword 0
temp dword 0
ReadedX dword 0
NumOfTerms dword 0
offsetOfEq dword 0
OutPut byte 70 dup(?),0
Sign dword 70 dup(-1)												
;#########################Q2 DATA##############################	
TragEquation byte 70 dup(-1)
SizeOFTrag dword 0
Sin byte "Cos(",0
Cos byte "Sin(",0
Tan byte "Sec^2(",0
Q2Sign byte 70 dup(-1)
Q2Co dword 70 dup(-1)
EQSize dword 0
ESITemp dword 0
ECXTemp dword 0
EBPTemp dword 0
SignOffsetTemp dword 0
CoFlagQ2 dword 0
SquareFlagQ2 dword 0
NTemsQ2 dword 0
;#########################Q3 DATA##############################	
EqDev byte 70 dup(-1)
IsMakam dword 0
bast byte 70 dup(-1)
makam byte 70 dup(-1)
NString dword 0
NBast dword 0
NMakam dword 0												
;#########################Q4 DATA##############################	
NumOfTermsQ4 dword 1
EquationQ4 byte 70 dup(-1)												
StartOfEverEquation dword 70 dup(-1)				
EndOfEverEquation dword 70 dup(-1)				
EDITemp dword 0
SizeOfEquationQ4 dword 0
.code													
														
;#######################################################
MAIN PROC                               			  ;#
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
		call crlf
		mov edx,offset Bonus						  ;#
		call writestring							  ;#
		call crlf									  ;#
		call crlf									  ;#
		call crlf
	PROGLOOP:
		mov esi,0
		mov ecx,70
		mov edi,0
		loopp:
			mov Co[esi],-1
			mov Power[esi],-1
			mov Return[esi],-1
			mov StartOfEverEquation[esi],-1
			mov EndOfEverEquation[esi],-1
			mov Q2Co[esi],-1
			mov Sign[esi],-1
			mov EqDev[edi],-1
			mov Q2Sign[edi],-1
			mov makam[edi],-1
			mov bast[edi],-1
			mov EquationQ4[edi],-1
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
		mov ecx,70
		mov edx,offset Equation
		call readstring
		call Q1	
		call crlf	
		JMP CONT								      ;#
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
		JNE _Q4 								      ;#
		mov edx,offset EnterEq
		call writestring							  ;#
		CALL Q3										  ;#
		JMP CONT									  ;#
			
		_Q4:
		CMP EAX,4    							      ;#
		JNE WRONG
		mov edx,offset EnterEq
		call writestring							  ;#
		CALL Q4										  ;#
		JMP CONT   

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
	mov ebp,offset Sign
	looop:

		movzx eax, Equation[edx]   ; Get the current character
		cmp eax,45 ; value is -
		je skip
		cmp eax,43 ; value is +
		je skip
		cmp eax,-1 ; value is -1
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
		mov [ebp],eax
		add ebp,4
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
	mov ebx,offset Sign
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
		je cont ;print only Co
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
		mov eax,88
		jmp cont

	PrintAll:
		mov al,'X'
		call writechar
		mov eax,88
		mov al,'^'
		call writechar
		mov eax,94
		mov eax,[edi]
		call writedec

	cont:
		add esi,4
		add edi,4
		dec ecx
		cmp ecx,0
		jne loop3
RET

Q1 ENDP
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

PrepairToPrint PROC
	mov edx, 0             ; dividend high half = 0.  prefer  xor edx,edx
	mov ebx, 10            ; divisor can be any register or memory
	div ebx ; Divides 1234 by 10.
			; EDX =   4 = 1234 % 10  quotient
			; EAX = 123 = 1234 / 10  remainder
RET
PrepairToPrint ENDP



;----------------------------------------------------------
;----------------------------------------------------------
Q2 PROC
mov ecx,70
mov edx,offset TragEquation
mov ebp,offset Q2Co
mov ebx,offset Q2Sign
call readstring
mov ecx,eax
mov SizeOFTrag,eax
mov esi,0
mov NTemsQ2,0
LoopQQQ1:
		mov al,TragEquation[esi]
		cmp ecx,SizeOFTrag
		je Check_FirstSign
		jmp S2

Check_FirstSign:
	inc NTemsQ2
	cmp al,'-'
	je FirstIsMince
	jmp FirstIsPositive
FirstIsMince:
	mov al,'-'
	mov [ebx],al
	inc ebx
	mov SignOffsetTemp,ebx
	mov ebx,0
	dec ecx
	inc esi
	jmp S2
FirstIsPositive:
	mov al,'+'
	mov [ebx],al
	inc ebx
	mov SignOffsetTemp,ebx
	mov ebx,0

S2:
mov al,TragEquation[esi]
cmp al,83 ;S
je Sin_Lable
cmp al,67 ;C
je Cos_Lable
cmp al,84 ;T
je Tan_Lable
cmp al,')'
je ContQ3_
cmp al,'+'
je RemoveAllFlag
cmp al,'-'
je RemoveAllFlag
cmp al,0
je ContQ3_
call CalcAppend2
mov CoFlagQ2,1
jmp ContQ3_

Sin_Lable:
	mov al,TragEquation[esi+3]
	cmp al,'^'
	je SinSq_Lable
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call SinProc
	mov EBPTemp,ebp
	mov al,'('
	call writechar
	mov eax,EQSize
	call Q1
	mov al,')'
	call writechar
	mov ebp,EBPTemp
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

SinSq_Lable:
	add esi,6
	sub ecx,6
	mov ESITemp,esi
	mov ECXTemp,ecx
	call SinSquareProc
	mov al,'('
	call writechar
	mov EBPTemp,ebp
	mov eax,EQSize
	call Q1
	mov ebp,EBPTemp
	mov al,')'
	call writechar
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

Cos_Lable:
	mov al,TragEquation[esi+3]
	cmp al,'^'
	je CosSq_Lable
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call CosProc
	mov EBPTemp,ebp
	mov al,'('
	call writechar
	mov eax,EQSize
	call Q1
	mov al,')'
	call writechar
	mov ebp,EBPTemp
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

CosSq_Lable:
	add esi,6
	sub ecx,6
	mov ESITemp,esi
	mov ECXTemp,ecx
	call CosSquareProc
	mov al,'('
	call writechar
	mov EBPTemp,ebp
	mov eax,EQSize
	call Q1
	mov ebp,EBPTemp
	mov al,')'
	call writechar
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

Tan_Lable:
	add esi,4
	sub ecx,4
	mov ESITemp,esi
	mov ECXTemp,ecx
	call TanProc
	mov EBPTemp,ebp
	mov al,'('
	call writechar
	mov eax,EQSize
	call Q1
	mov al,')'
	call writechar
	mov ebp,EBPTemp
	mov esi,ESITemp
	mov ecx,ECXTemp
	jmp ContQ3_

RemoveAllFlag:
	inc NTemsQ2
	mov ebx,SignOffsetTemp
	mov [ebx],al
	inc ebx
	mov SignOffsetTemp,ebx
	mov SquareFlagQ2,0
	mov SquareFlagQ2,0
	mov ebx,0

ContQ3_:
	add eax,0
	inc esi
	dec ecx
	cmp ecx,0
	jne LoopQQQ1
call crlf
		RET


Q2 ENDP 

;#########################
CalcAppend2 PROC
	movzx eax,TragEquation[esi]
    sub eax, 48             ; Convert from ASCII to decimal 
    imul ebx, 10            ; Multiply total by 10
    add ebx, eax            ; Add current digit to total
		RET
CalcAppend2 ENDP
;########################################################################
SinProc PROC

cmp CoFlagQ2,1
je assignCo
CofIsOne:
	mov eax,1
	mov [ebp],eax
	mov ebx,0
	jmp Continue

assignCo:
	mov [ebp],ebx
	mov ebx,0

Continue:
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'+'
	jne PrintMince
	cmp NTemsQ2,1
	je PrintCo
	call writechar
	jmp PrintCo

PrintMince:
	cmp al,'-'
	call writechar

PrintCo:
	mov eax,[ebp]
	cmp eax,1
	jle Outq1
	call writedec
	add ebp,4

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
;##########################################################

SinSquareProc PROC
cmp CoFlagQ2,1
je assignCo
CofIsOne:
	mov eax,1
	mov [ebp],eax
	jmp Continue

assignCo:
	mov [ebp],ebx
	cmp ecx,0
	mov CoFlagQ2,1

Continue:
	call PrintSignSinTragProc
	mov eax,[ebp]
	cmp eax,1
	jle Outq1
	call writedec
	add ebp,4

Outq1:
	mov EQSize,0
	mov edx,offset Cos
	call writestring
	mov ESITemp,esi
	call EmptyArrays
	mov esi,ESITemp
	mov edi,offset Equation
	mov ecx,ECXTemp
	mov al,'2'
	call writechar
	mov al,'('
	call writechar
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
	mov al,')'
	call writechar
	mov al,'*'
	call writechar
	mov eax,EQSize
	mov ESITemp,esi
	mov ECXTemp,ecx
RET
SinSquareProc ENDP

;#######################################################################
CosProc PROC
cmp CoFlagQ2,1
je assignCo
CofIsOne:
	mov eax,1
	mov [ebp],eax
	mov ebx,0
	jmp Continue

assignCo:
	mov [ebp],ebx
	mov ebx,0

Continue:
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'-'
	jne PrintMince
	cmp NTemsQ2,1
	je PrintCo
	mov al,'+'
	call writechar
	jmp PrintCo

PrintMince:
	mov al,'-'
	call writechar

PrintCo:
	mov eax,[ebp]
	cmp eax,1
	jle Outq1
	call writedec
	add ebp,4

Outq1:
	mov EQSize,0
	mov edx,offset Cos
	call writestring
	mov ESITemp,esi
	call EmptyArrays
	mov esi,ESITemp
	mov edi,offset Equation
	mov ecx,ECXTemp
	mov eax,offset TragEquation ;;;;;;;;;;;;;;ForTestOnly
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
;#################################################

CosSquareProc PROC
cmp CoFlagQ2,1
je assignCo
CofIsOne:
	mov eax,1
	mov [ebp],eax
	mov ebx,0
	jmp Continue

assignCo:
	mov [ebp],ebx
	mov ebx,0

Continue:
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'-'
	je PrintMince
	cmp NTemsQ2,1
	je PrintCo
	mov al,'+'
	call writechar
	jmp PrintCo

PrintMince:
	mov al,'-'
	call writechar

PrintCo:
	mov eax,[ebp]
	cmp eax,1
	jle Outq1
	call writedec
	add ebp,4

Outq1:
	mov EQSize,0
	mov edx,offset Cos
	call writestring
	mov ESITemp,esi
	call EmptyArrays
	mov esi,ESITemp
	mov edi,offset Equation
	mov ecx,ECXTemp
	mov al,'2'
	call writechar
	mov al,'('
	call writechar
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
	mov al,')'
	call writechar
	mov al,'*'
	call writechar
	mov eax,EQSize
	mov ESITemp,esi
	mov ECXTemp,ecx
RET
CosSquareProc ENDP
;################################################################################3
TanProc PROC
cmp CoFlagQ2,1
je assignCo
CofIsOne:
	mov eax,1
	mov [ebp],eax
	mov ebx,0
	jmp Continue

assignCo:
	mov [ebp],ebx
	mov ebx,0

Continue:
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'-'
	je PrintMince
	cmp NTemsQ2,1
	je PrintCo
	mov al,'+'
	call writechar
	jmp PrintCo

PrintMince:
	mov al,'-'
	call writechar

PrintCo:
	mov eax,[ebp]
	cmp eax,1
	jle Outq1
	call writedec
	add ebp,4

Outq1:
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

PrintSignSinTragProc PROC
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'-'
	je PrintMince
	cmp NTemsQ2,1
	je Skip
	mov al,'+'
	call writechar
	jmp Skip

PrintMince:
	mov al,'-'
	call writechar

Skip:
	add ebx,0
RET
PrintSignSinTragProc ENDP
;#######################################
PrintSignCosTragProc PROC
	mov ebx,SignOffsetTemp
	mov al,[ebx-1]
	cmp al,'+'
	je PrintMince
	cmp NTemsQ2,1
	je Skip
	mov al,'+'
	call writechar
	jmp Skip

PrintMince:
	mov al,'-'
	call writechar

Skip:
	add ebx,0
RET
PrintSignCosTragProc ENDP

;----------------------------------------------------------
;----------------------------------------------------------

Q3 PROC
mov ecx,70
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
		mov ecx,70
		loopp:
			mov Co[esi],-1
			mov Equation[edi],-1
			mov Power[esi],-1
			add esi,4
			inc edi
		loop loopp	
RET
EmptyArrays ENDP



;###################################################Bonus##################################

Q4 PROC
	
mov ecx,70
mov edx, offset EquationQ4
call readstring
mov NumOfTermsQ4,0
mov SizeOfEquationQ4,eax
mov ecx,eax
mov edi,0
mov esi,offset StartOfEverEquation
mov ebp,offset EndOfEverEquation
loop_1Q4:

	mov al,EquationQ4[edi]
	cmp al,'('
	je IncrementNumOfTermsQ4
	cmp al,')'
	je AssignEndEquation
	jmp SkipQ4
AssignEndEquation:
	mov [ebp],edi
	add ebp,4
	jmp SkipQ4

IncrementNumOfTermsQ4:
	inc NumOfTermsQ4
	mov [esi],edi
	add esi,4

SkipQ4:
	inc edi

loop loop_1Q4
;########################

mov esi,0

loop_2Q4:
mov ecx,StartOfEverEquation[esi]
mov ebp,offset EquationQ4
cmp ecx,0
je SkipFromFirstPrint

loopQ4In_1:
	mov al,[ebp]
	call writechar
	inc ebp
loop loopQ4In_1
;#########################
SkipFromFirstPrint:
mov ESITemp,esi
call EmptyArrays
mov esi,ESITemp
mov eax,EndOfEverEquation[esi]
sub eax,StartOfEverEquation[esi]
sub eax,1
mov ecx,eax
mov edx,offset Equation
mov NString,0
mov al,'('
call writechar
inc ebp
loopSendToQ1:
mov al,[ebp]
mov [edx],al
inc NString
inc ebp
inc edx
loop loopSendToQ1
mov eax,NString
mov ESITemp,esi
mov EBPTemp,ebp
call Q1
mov al,')'
call writechar
mov esi,ESITemp
mov ebp,EBPTemp
inc ebp


mov ecx,SizeOfEquationQ4
sub ecx,EndOfEverEquation[esi]
dec ecx
cmp ecx,0
je JumpStart
loopQ4In_3:
	mov al,[ebp]
	call writechar
	inc ebp
loop loopQ4In_3
mov al,'+'
call writechar


JumpStart:
	dec NumOfTermsQ4
	ADD esi,4
	cmp NumOfTermsQ4,0
	jne loop_2Q4 


RET
Q4 ENDP

;----------------------------------------------------------
;----------------------------------------------------------
END MAIN