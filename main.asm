INCLUDE Irvine32FCIS.inc ;DO NOT CHANGE THIS LINE
						
.data																				
EnterEq byte "Enter Equation To Solve: ",0
Equation byte 35 dup(-1)
Co dword 35 dup(-1)
Power dword 35 dup(-1)
Sign dword 35 dup(?)
Val byte 0
PowerFlag byte 0
LenghtOfEnterd dword 0
temp word 0
ReadedX dword 0
NumOfTerms dword 0
offsetOfEq dword 0
													
.code													
MAIN PROC											  ;#
Start:
	mov esi,0
	mov ecx,35
	loopp:
		mov Co[esi],-1
		mov Power[esi],-1
		mov Sign[esi],-1
		add esi,4
	loop loopp
	mov NumOfTerms,0
	mov edx,offset EnterEq
	call writestring
	mov ecx,35
	mov edx,offset Equation
	call readstring
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

	call crlf
	jmp Start
exit
MAIN ENDP
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
RET
AddFirstPlusProc ENDP

											  ;#
END MAIN