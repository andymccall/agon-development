;
; Title:		          05-bitmap
;
; Description:            A program that shows a 16x16 bitmap to the screen
;                         on the Agon Light 2
;
; Author:                 Andy McCall, mailme@andymccall.co.uk
;
; Created:		          Sat 24 Aug 18:29:18 BST 2024
; Last Updated:
;
; Modinfo:

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

SCREENMODE_320x240_64:   equ 8

start:
    push af
    push bc
    push de
    push ix
    push iy

; Set the screen mode
	ld a, 22
	rst.lil $10
	ld a, SCREENMODE_320x240_64
	rst.lil $10

; Sending a VDU byte stream
    ld hl, zombie_data                      ; address of string to use
    ld bc, end_zombie_data - zombie_data    ; length of string
    rst.lil $18                             ; Call the MOS API to send data to VDP 

    ld a, $08                               ; code to send to MOS

loop:
    jr loop

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret

zombie:    EQU     0                    ; bitmap ID 0 will be the zombie

zombie_data:
    .db 23, 0, 192, 0                   ; non-scaled graphics

    .db 23, 27, 0, zombie               ; bitmap 0 - zombie
    .db 23, 27, 1                       ; load bitmap data
    .dw 16, 16                          ; 16x16 pixels
    incbin     "src/zombie.data"

    .db 23, 27, 0, zombie
    .db 25, $ED
    .dw 100, 100                         ; X, Y location

end_zombie_data: