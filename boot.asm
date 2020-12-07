;boot.asm
;The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00.
   mov ax, 0x07c0
   mov ds, ax
   mov si, msg

; Since the 'Hello World' msg is contained in the program, the msg will
; be at some address ahead of 0x7c00.
;
; 'si' is Source Index Register. Used as source in some string processing
; instructions. Offset address relative to 'ds'.

   cld
; Clears the DF (direction flag) in the EFLAGS register. When the DF flag
; is set to 0, string operations increment the index registers (ESI and/or
; EDI).
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
ch_loop:
   lodsb
   ; loads a string byte into 'al' register. (character size is one byte).

   or al, al ; OR operation.
   jz hang   ; get out
   ; Since 'lodsb' loads a byte into 'al', if the 'Hello World' msg is read
   ; completely, it will then read and print 13 and 10 (See msg section) for
   ; return carriage and newline.
   ;
   ; The last byte is zero, which will be read and 0|0 will be equal to zero
   ; and it also sets the zero flag.

   ; 'jz' (jump if zero) will then move to next task.

   mov ah, 0x0E
   mov bh, 0
   int 0x10
   ; Print using interrrupt.

   jmp ch_loop
 
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
hang:
   jmp hang    ; Infinite loop.

; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
msg   db 'Hello World. I am Ajiaty. The message is printed by BIOS.', 13, 10, 0
         ; ASCII value 13 means carriage return.
         ; ASCII value 10 means new line.
         ; AsCII value 0 means NULL, end of string.
 
   times 510-($-$$) db 0
         ; '$' evaluates to the assembly position at the beginning of the line
         ; containing the expression. '$$' evaluates to the beginning of the
         ; current section; so you can tell how far into the section you are
         ; by using ($-$$).

   db 0x55
   db 0xAA
