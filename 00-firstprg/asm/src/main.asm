;
; Title:		   00-firstprg - Assembler Example
;
; Description:     A program that does nothing for the Agon Light 2
;                  intended to check your environment works with no
;                  issues
; Author:		   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   2024-08-22 @ 17:41
; Last Updated:	   2024-08-22 @ 17:41
;
; Modinfo:
;

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

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret