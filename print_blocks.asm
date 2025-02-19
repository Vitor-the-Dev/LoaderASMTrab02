section .data

blk1_dbg db "block 1 start debug", 0
blk2_dbg db "block 2 start debug", 0
blk3_dbg db "block 3 start debug", 0
blk4_dbg db "block 4 start debug", 0


allocating db "allocating:  ", 0
totalsize db "free space:  ", 0

startprogrm db "Allocation start", 0Ah, "=-=-=-=-=-=-=-=-=-=-=", 0Ah, 0
startprogrm_len equ $ - startprogrm
endprogrm db "Successfully allocated memory", 0Ah, "=-=-=-=-=-=-=-=-=-=-=", 0Ah, 0
endprogrm_len equ $ - endprogrm

blk2_2dbg db "block 2 end debug", 0

failure db 'Error! Insufficient memory!',0Ah, "=-=-=-=-=-=-=-=-=-=-=", 0Ah, 0
failure_len equ $ - failure

blk1_start db "Block 1 Start: ",0
blk1_end   db "Block 1 End: ",0
blk2_start db "Block 2 Start: ",0
blk2_end   db "Block 2 End: ",0
blk3_start db "Block 3 Start: ",0
blk3_end   db "Block 3 End: ",0
blk4_start db "Block 4 Start: ",0
blk4_end   db "Block 4 End: ",0
newline    db 0xA,0xD
buffer     times 11 db 0  


section .text
global printBlocks


print_number:
    pusha
    mov edi, buffer + 10
    mov byte [edi], 0
    mov ecx, 10
    
.convert_loop:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .convert_loop
    
    
    mov eax, 4      
    mov ebx, 1      
    mov ecx, [esp + 16]  
    mov edx, 14
    int 0x80
    
    mov eax, 4
    mov ecx, edi
    mov edx, buffer + 10
    sub edx, edi
    int 0x80
    
    mov eax, 4
    mov ecx, newline
    mov edx, 2
    int 0x80
    
    popa
    ret





printBlocks:

    push ebp
    mov ebp, esp


    ;our stack is size, size, block1start, block1size, block1end, block2start, block2size, block2end, block3start, block3size, block3end, block4start, block4size, block4end
    ;setting up our stack on ebp
        ;size = [ebp + 8]       ;
    ;size = [ebp + 12]    
    ;block1start = [ebp + 16] 
    ;block1size = [ebp + 20]  
    ;remaining1 = [ebp + 24]  
    ;usedsize1 = [ebp + 28]   
    ;block1end = [ebp + 32]   
    ;block2start = [ebp + 36] 
    ;block2size = [ebp + 40]  
    ;remaining2 = [ebp + 44] 
    ;usedsize2 = [ebp + 48]   
    ;block2end = [ebp + 52]   
    ;block3start = [ebp + 56] 
    ;block3size = [ebp + 60]  
    ;remaining3 = [ebp + 64] 
    ;usedsize3 = [ebp + 68]   
    ;block3end = [ebp + 72]   
    ;block4start = [ebp + 76] 
    ;block4size = [ebp + 80]  
    ;remaining4 = [ebp + 84]  
    ;usedsize4 = [ebp + 88]   
    ;block4end = [ebp + 92]   

.defines:
;defines for local variables in ouur stack, since those are not global variables, there is no problem with the project specs 
%define size1        [ebp+8]    ;argv[1]
%define size2        [ebp+12]   ;argv[1] 
%define block1start  [ebp+16]   ;argv[2] 
%define block1size   [ebp+20]   ;argv[3] 
%define remaining1   [ebp+24]   ;argv[3]
%define usedsize1    [ebp+28]   ;0
%define block1end    [ebp+32]   ;argv[2] 
%define block2start  [ebp+36]   ;argv[4]
%define block2size   [ebp+40]   ;argv[5]
%define remaining2   [ebp+44]   ;argv[5]
%define usedsize2    [ebp+48]   ;0
%define block2end    [ebp+52]   ;argv[4]
%define block3start  [ebp+56]   ;argv[6]
%define block3size   [ebp+60]   ;argv[7]
%define remaining3   [ebp+64]   ;argv[7]
%define usedsize3    [ebp+68]   ;0
%define block3end    [ebp+72]   ;argv[6]
%define block4start  [ebp+76]   ;argv[8]
%define block4size   [ebp+80]   ;argv[9]
%define remaining4   [ebp+84]   ;argv[9]
%define usedsize4    [ebp+88]   ;0
%define block4end    [ebp+92]   ;argv[8]
;debug 1

    
    ;pusha
    ;mov eax, block1start
    ;mov ebx, blk1_dbg
    ;call print_number

    ;pusha
    ;mov eax, block2start
    ;mov ebx, blk2_dbg
    ;call print_number

    ;pusha
    ;mov eax, block3start
    ;mov ebx, blk3_dbg
    ;call print_number

    ;pusha
    ;mov eax, block4start
    ;mov ebx, blk4_dbg
    ;call print_number


; ---------------
;greetings
; --------------

    mov eax, 4
    mov ebx, 1
    mov ecx, startprogrm
    mov edx, startprogrm_len
    int 0x80

    mov eax, block1size
    add eax, block2size
    add eax, block3size
    add eax, block4size
    

    pusha
    mov ebx, totalsize
    call print_number

    pusha
    mov eax, size1
    mov ebx, allocating
    call print_number

; --------------
.fitfirst:
; ---------------

    ;todo fix this, will not fit first, done

    ;see if any block is bigger than program size, if yes, jump to that block standalone calculator (will then straight jump to print)
    mov eax, size1 ;get size
    mov ebx, block1size ;get block1 size
    cmp ebx, eax ;compare with size block 1
    jge .block1st

    mov ebx, block2size ;block2 size
    cmp ebx, eax ;compare with size block 2
    jge .block2st

    mov ebx, block3size ;block3 size
    cmp ebx, eax ;compare ;with size block 3
    jge .block3st

    mov ebx, block4size ;block4 size
    cmp ebx, eax ;compare ;with size block 4
    jge .block4st





; ---------------------
.block1st: ;standalone func for block 1
; ---------------------

    


    mov eax, remaining1   ;set EAX to remaining
    sub eax, size2    ;Subtract size
    jge .no_underflow1     ;Jump if the result >= 0
    xor eax, eax    ;Set to 0 if negative




.no_underflow1:
    mov remaining1, eax   ;Store updated remaining

    ;usedsize = blocksize - remaining
    mov eax, block1size   ;EAX = blocksize
    sub eax, remaining1   ;Subtract updated remaining
    mov usedsize1, eax   ;Store usedsize
    mov edx, size2    ;Load original size
    sub edx, eax          ;Subtract calculated usedsize (still in EAX)
    mov size2, edx    ;pdate size with new value


    ;blockend = blockstart + usedsize - 1
    mov eax, block1start   ;set EAX to remaining
    add eax, usedsize1   ;Add usedsize
    ;dec eax               ;Subtract 1
    mov block1end, eax   ;Store blockend



; ---------------------
.block2st: ;standalone func for block 2
; ---------------------



    mov eax, remaining2   ;EAX = remaining
    sub eax, size2    ;Subtract size
    jge .no_2underflow     ;Jump if result >= 0
    xor eax, eax          ;Set to 0 if negative


.no_2underflow:
    mov remaining2, eax   ;Store updated remaining

    ;usedsize = blocksize - remaining
    mov eax, block2size   ;EAX = blocksize
    sub eax, remaining2   ;Subtract updated remaining
    mov usedsize2, eax   ;Store usedsize
    mov edx, size2    ;Load original size
    sub edx, eax          ;Subtract calculated usedsize (still in EAX)
    mov size2, edx    ;Update size with new value


    ;pusha
    ;mov eax, block2start
    ;mov ebx, blk2_2dbg
    ;call print_number

    ;pusha
    ;mov eax, usedsize2
    ;mov ebx, blk2_2dbg
    ;call print_number

    ; Step 3: blockend = blockstart + usedsize - 1
    mov eax, block2start   ;EAX = blockstart
    add eax, usedsize2   ;Add usedsize
    ;dec eax               ;Subtract 1
    mov block2end, eax   ;Store blockend

    ;pusha
    ;mov eax, block2end
    ;mov ebx, blk2_2dbg
    ;call print_number

    


; ---------------------
.block3st: ;standalone func for block 2
; ---------------------


    mov eax, remaining3   ;EAX = remaining
    sub eax, size2    ;Subtract size
    jge .no_underflow3     ;Jump if result >= 0
    xor eax, eax          ;Set to 0 if negative


.no_underflow3:
    mov remaining3, eax   ;Store updated remaining

    ;usedsize = blocksize - remaining
    mov eax, block3size   ;EAX = blocksize
    sub eax, remaining3   ;Subtract updated remaining
    mov usedsize3, eax   ;Store usedsize
    mov edx, size2    ;Load original size
    sub edx, eax          ;Subtract calculated usedsize (still in EAX)
    mov size2, edx    ;Update size with new value


    ;blockend = blockstart + usedsize - 1
    mov eax, block3start   ;EAX = blockstart
    add eax, usedsize3   ;Add usedsize
    ;dec eax               ;Subtract 1
    mov block3end, eax   ;Store blockend

; ---------------------
.block4st: ;standalone func for block 2
; ---------------------


    mov eax, remaining4   ;EAX = remaining
    sub eax, size2    ;Subtract size
    jge .no_underflow4     ;Jump if result >= 0
    xor eax, eax          ;Set to 0 if negative


.no_underflow4:
    mov remaining4, eax   ;Store updated remaining

    ;usedsize = blocksize - remaining
    mov eax, block4size   ;EAX = blocksize
    sub eax, remaining4   ;Subtract updated remaining
    mov usedsize4, eax   ;Store usedsize
    mov edx, size2    ;Load original size
    sub edx, eax          ;Subtract calculated usedsize (still in EAX)
    mov size2, edx    ;Update size with new value


    ;blockend = blockstart + usedsize - 1
    mov eax, block4start   ;EAX = blockstart
    add eax, usedsize4   ;Add usedsize
    ;dec eax               ;Subtract 1
    mov block4end, eax   ;Store blockend



;jump to fail if no memory
mov eax, size2        ;Load size value 
test eax, eax             ;Check if zero
jnz .fail                ;Jump if not zero

.block1: ;Print Block 1
    
    ;jump to block 2 if not used
    mov eax, usedsize1 
    test eax, eax  
    je .block2      

    pusha
    mov eax, block1start
    mov ebx, blk1_start
    call print_number
    
    mov eax, block1end
    mov ebx, blk1_end
    call print_number
    popa

    
.block2: ;Print Block 2
    
    ;jump to block 2 if not used
    mov eax, usedsize2        
    test eax, eax             
    je .block3                


    pusha
    mov eax, block2start
    mov ebx, blk2_start
    call print_number
    
    mov eax, block2end
    mov ebx, blk2_end
    call print_number
    popa

.block3: ;Print Block 3
    

    ;jump to block 3 if not used
    mov eax, usedsize3       
    test eax, eax             
    je .block4                 


    pusha
    mov eax, block3start
    mov ebx, blk3_start
    call print_number
    
    mov eax, block3end
    mov ebx, blk3_end
    call print_number
    popa

.block4: ;Print Block 4
    


    ;jump to end if not used
    mov eax, usedsize4       
    test eax, eax             
    je .exit                

    pusha
    mov eax, block4start
    mov ebx, blk4_start
    call print_number
    
    mov eax, block4end
    mov ebx, blk4_end
    call print_number
    popa

;jump to exit if successful
mov eax, size2        
test eax, eax             
je .exit               

.exit: ;Exit
    
    mov eax, 4
    mov ebx, 1
    mov ecx, endprogrm
    mov edx, endprogrm_len
    int 0x80

    mov eax, 1 ;exit   
    xor ebx, ebx     
    int 0x80

.fail:

    mov eax, 4
    mov ebx, 1
    mov ecx, failure
    mov edx, failure_len
    int 0x80

    mov eax, 1 ;exit   
    xor ebx, ebx     
    int 0x80


;clean everything up
mov esp, ebp      
pop ebp           
ret               