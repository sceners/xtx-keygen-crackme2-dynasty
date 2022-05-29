;==========================================================================================================================================
;									      
	;				;												  Source Keygen de SPOKE3FFF		  
					;														Avril  2008				    
						;											     CrackMe#2 by Dynasty  
					;														Merci a lui 
;																	       
; ==========================================================================================================================================																				      
;									  
;
; ///////////////////////////////////////////////////////////////////////////	INCLUDES \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
.386 
.model flat,stdcall 
option casemap:none 

include			windows.inc 
include			kernel32.inc 
include			user32.inc
include			ufmodapi.inc

includelib		kernel32.lib
includelib		user32.lib 
includelib		ufmod.lib
includelib		winmm.lib

DlgProc			proto		:DWORD,:DWORD,:DWORD,:DWORD
FadeIn			proto		:DWORD
FadeOut			proto		:DWORD
Generate		         proto		          :DWORD

; /////////////////////////////////////////////////////////////////////////////// SECTION .DATA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.data							    ; contient les msgbox , déclarations de variables

	include chiptune.inc			      ; include pour la musique 
	xmSize equ $ - table
	Formatdec		db		"%d-1243916",0	  ; 2eme partie du serial hard coded
	
	;pour le serial
	vide	 db "Entrez un nom,sinon pas de serial ",0
	trp_long db "20 caractères MAXI",0


AboutTxt	       db		   "                CrackMe#2 codé par Dynasty                      ",10,13 ; contenu texte de la msgbox FENETRE ABOUT "A PROPOS"
			db		"          UN GRAND MERCI à lui pour son travail       ",10,13
			db		"                                                                       ",10,13
			db		"                       Keygen CrackMe#2                             ",10,13
			db		"                          codé par Sp0ke                     ",10,13
			db		   "                        en  ASM (MASM32)                       ",10,13
			db		   "                          GFX par Sp0ke                      ",10,13
			db		   "                            Avril 2008                                 ",10,13
			db		" ",10,13
			db		   "                      UN GRAND MERCI  à :                      ",10,13
			db		"                    Goldocrack ,pour son aide                 ",10,13 
			db		"                     X-TReM,DcSpirou,Burner,                ",10,13 
			db		   "                              TeaM XTX              ",10,13
			db		" ",10,13
			db		"                 et à tous pour leur sympatie              ",10,13
			db		"          et tous les membres de  la TeaM XTX           ",10,13
			db		"                            http://xtx.free.fr                    ",10,13
			db		"     Merci à Mars pour ses tutos et son aide,           ",10,13
			db		"                       de chez  ForumCrack                      ",10,13
			db		"  Merci à Dynasty et ses Modos pour leurs tutos       ",10,13
			db		"                  http://deezdynasty.xdir.org                ",10,13
			db		"              Merci à toutes les autres Teams              ",10,13
			db		" Je m'excuse pour  tous les autres que j'ai oublié    ",10,13
			db		" ",0
AboutCap		db		"A propos du CrackMe#2 par Dynasty ",0	;CAPTION (TITRE) DE LA FENETRE ABOUT "A PROPOS"




;////////////////////////////////////////////////////////////////////////////// SECTION .DATA? \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
.data? 

	hInstance	       dd	    ?
	Transparency		dd		?
	BufferNom		db		40 dup(?) 
	SerialBuffer		db		40 dup(?)
	SerialSection		db		32 dup(?)
	long			  db	      40 dup(?)
	

;////////////////////////////////////////////////////////////////////////////////ID DES BOUTONS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.data? 
.const
	IDD_KEYGEN		       equ		1001
	IDC_EXIT			      equ		1002
	IDC_COPY		       equ		1003 
	IDC_ABOUT		       equ		1004
	IDC_NAME		       equ		1005
	IDC_SERIAL		       equ		1006
	ICON			       equ		2001
	LWA_ALPHA		       equ		2
	LWA_COLORKEY		equ		1
	WS_EX_LAYERED		equ		80000h
	DELAY_VALUE		       equ		10

;////////////////////////////////////////////////////////////////////////////////// SECTION .CODE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

.code 
start: 
	invoke GetModuleHandle,NULL 
	mov hInstance,eax 
	invoke DialogBoxParam,hInstance,IDD_KEYGEN,NULL,addr DlgProc,NULL 
	invoke ExitProcess,eax 
	
	
;/////////////////////////////////////////////////////////////////////////////// DIALOG PROCESS, ACTION DES BOUTONS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	
    
DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM 
	.if uMsg == WM_INITDIALOG
		invoke GetWindowLong,hWnd,GWL_EXSTYLE 
		or eax,WS_EX_LAYERED 
		invoke SetWindowLong,hWnd,GWL_EXSTYLE,eax 
		invoke SetWindowPos,hWnd,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE+SWP_NOSIZE	
		invoke LoadIcon,hInstance,ICON 
		invoke SendMessage,hWnd,WM_SETICON,1,eax
		invoke GetDlgItem,hWnd,IDC_NAME
		invoke SetFocus,eax 
		invoke uFMOD_PlaySong,addr table,xmSize,XM_MEMORY
		invoke FadeIn,hWnd
	.elseif uMsg==WM_LBUTTONDOWN							
		invoke SendMessage,hWnd,WM_NCLBUTTONDOWN,HTCAPTION,lParam
	.elseif uMsg==WM_COMMAND
		mov eax,wParam
		.if ax==IDC_NAME
			shr eax,16
		.if ax==EN_CHANGE
			invoke Generate,hWnd
		.endif
	.elseif eax==IDC_ABOUT
		invoke MessageBox,hWnd,addr AboutTxt,addr AboutCap,MB_OK	
	.elseif eax==IDC_COPY
		invoke SendDlgItemMessage,hWnd,IDC_SERIAL,EM_SETSEL,0,-1 
		invoke SendDlgItemMessage,hWnd,IDC_SERIAL,WM_COPY,0,0 
	.elseif eax==IDC_EXIT 
		invoke	SendMessage,hWnd,WM_CLOSE,0,0
	.endif
	.elseif	uMsg== WM_CLOSE
		invoke FadeOut,hWnd	
		invoke uFMOD_PlaySong,0,0,0 
		invoke EndDialog,hWnd,0 
	.endif	      
	xor eax,eax
	ret 
DlgProc endp 

;/////////////////////////////////////////////////////////////////////////////// EFFET Fondu sur arrivée d'image\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

FadeIn proc hWnd:HWND

	invoke ShowWindow,hWnd,SW_SHOW
	mov Transparency,65
@@:
	invoke SetLayeredWindowAttributes,hWnd,0,Transparency,LWA_ALPHA
	invoke Sleep,DELAY_VALUE
	add Transparency,5
	cmp Transparency,205
	jne @b
	ret 
	
FadeIn endp

;//////////////////////////////////////////////////////////////////////////////// EFFET Fondu sur sortie d'image \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

FadeOut proc hWnd:HWND

	mov Transparency,255
@@:
	invoke SetLayeredWindowAttributes,hWnd,0,Transparency,LWA_ALPHA
	invoke Sleep,DELAY_VALUE
	sub Transparency,5
	cmp Transparency,0
	jne @b
	ret
FadeOut endp




;////////////////////////////////////////////////////////////////////////////////ROUTINE DE GENERATION SERIAL\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Generate proc hWnd:HWND

	;============================== Generate Keygen Crackme#2 by Dynasty =======================================================================================
		invoke GetDlgItemText,hWnd,IDC_NAME,addr BufferNom,20	   ; il invoque l'editboxe du Nom pour récuper les caractères dès la saisie
			cmp eax,0										   ; il vérifie si un caractère est frappé  dans l'editboxe du Nom
		je @vide												  ; Si il n'y a pas de caractère il affiche le message "Entrez un Nom pour avoir un serial"
			cmp eax,20										   ; il vérifie que le serial ne dépasse pas 20 caractères
		jg trop_long											   ; Si ça dépasse il saute vers le message "20 caractères MAXI"
			mov ecx,11h									; Il place la valeur 11h = 17 en décimale (Nb de caractères du serial)
			MOV ESI,offset BufferNom							   ;  il place le BufferNom dans ESI
			xor ebx,ebx									 ; Il initialise ebx pour travailler avec
			xor edx,edx									 ; Il initialise edx pour travailler avec
		@@:										       
			PUSH eax									    ; push sur la pile eax
			XOR eax,eax									  ; il initialise eax	
			MOV AL,BYTE PTR dS:[edx+esi]						; il récupère les caractères du Nom un à un 
			IMUL eax,0Bh									  ; multiplie eax par OBh
			ROR eax,2									   ; le résultat ROR 2
			XOR eax,38h									  ; XOR eax par 038h
			ADD eax,7A5h									 ; il additionne 07A5h à eax
			ADD ebx,eax									  ; il additionne eax à ebx
			INC edx 									     ; il Incrémente EDX (qui est le 1 er compteur )								       
			pop eax 									     ; il retire eax de la pile			
			CMP eax,edx									  ; il Compare EDX(nb de passage en boucle) à EAX (valeur de chaque caractères du Nom)
		jne @b											     ; il Boucle tant qu'il n'a pas compté tout les caractères
		
		boucle2:
			PUSH eCx									   ; push sur la pile ecx			
			XOR ecx,ecx									  ; il initialise ecx	
			IMUL ecx,0Bh									  ; multiplie ecx par OBh
			ROR ecx,2									   ; le résultat ROR 2
			XOR ecx,38h									  ; XOR eax par 038h
			ADD ecx,7A5h									 ; il additionne 07A5h à ecx
			ADD ebx,ecx									  ; il additionne ecx à ebx
			INC edx 									     ; il Incrémente ECX (qui est le 2 em compteur )								       
			pop ecx 									     ; il retire eax de la pile			
			CMP ecx,edx									  ; il Compare EDX(nb de passage en boucle) à ECX (valeur de chaque caractères du Nom)
		jne boucle2
		
			xor eax,eax
			mov eax,0Ch									 ; place OCh dans eax
			MUL ebx 									    ; multiplie par ebx
			IMUL eax,2									   ; il multiplie eax par 2
			XOR eax,36h									  ; XOR eax par 036h
			ROL eax,7									    ; ROL eax par 7
			
			
		invoke wsprintfA,addr BufferNom,addr Formatdec,eax		 ; il invoque wsprintf pour la conversion du serial en décimale
		invoke SetDlgItemText,hWnd,IDC_SERIAL,addr BufferNom	     ; il invoque l'handle de l'editbox du Serial pour y afficher le serial
			ret
		@vide:
			invoke SetDlgItemText,hWnd,IDC_SERIAL,addr vide 	   ; il invoque l'handle de l'editbox du Serial pour y afficher un message si aucun caractère n'est entré
			ret
			trop_long:
			invoke SetDlgItemText,hWnd,IDC_SERIAL,addr trp_long	; il invoque l'handle de l'editbox du Serial pour y afficher un message si le Nom dépasse 20 caractères
			ret
	;===============================================================================================================================================		
Generate endp  ;  fin de génération du serial

end start   ;  FIN
