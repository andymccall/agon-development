;
; Title:		       01-hellochar - Assembler Example
;
; Description:         A program that outputs a character on the Agon Light 2
;                      
; Author:		       Andy McCall, mailme@andymccall.co.uk
;
; Created:		       2024-08-22 @ 18:21
; Last Updated:	       2024-08-22 @ 18:21
;
; Modinfo:

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

start:
    push af
    push bc
    push de
    push ix
    push iy

    ld a,'A'
    rst.lil $10

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret
