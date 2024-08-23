;
; Title:		       03-setscreen - Assembler Example
;
; Description:         A program that sets the screen color on the Agon Light 2
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

COLOR_RED:            equ     1
COLOR_GREEN:          equ     2
COLOR_BLUE:           equ     4
COLOR_WHITE:          equ     7
COLOR_BLACK:          equ     0
COLOR_BRIGHT_WHITE:   equ     15

start:
    push af
    push bc
    push de
    push ix
    push iy

; Set the text color
	ld a, 17					; set text colour
	rst.lil $10
	ld a, COLOR_BLACK			; colour to use
	rst.lil $10

; Set the background color
    ld a, 17					; set text colour
	rst.lil $10
	ld a, COLOR_RED				; colour to use
	add a, 128
	rst.lil $10

; Clear the screen
	ld a, 12
	rst.lil $10

; Print the message
    ld hl,color_msg
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

color_msg:
    .db "Set the screen color to red!",13,10,0
