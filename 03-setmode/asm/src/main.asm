;
; Title:		       03-setmode - Assembler Example
;
; Description:         A program that sets the screen mode on the Agon Light 2
;                      
; Author:		       Andy McCall, mailme@andymccall.co.uk
;
; Created:		       2024-08-23 @ 14:24
; Last Updated:	       2024-08-23 @ 14:24
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

	ld a, 22
	rst.lil $10
	ld a, 8
	rst.lil $10

    ld hl,mode_msg
    ld bc,0
    ld a,0
    rst.lil $18

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret

mode_msg:
    .db "Changed screen mode to 320x240x64!",13,10,0
