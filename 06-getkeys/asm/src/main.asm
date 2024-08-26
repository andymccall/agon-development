;
; Title:		       06-getkeys
;
; Description:         An example of getting key input on the Agon
;                      Light 2    
;
; Author:              Andy McCall, mailme@andymccall.co.uk
;
; Created:		       Mon 26 Aug 12:20:11 BST 2024
; Last Updated:
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

    ; Display the start message
    ld hl, start_msg
    ld bc,0
    ld a,0
    rst.lil $18

    ld a, $08
    rst.lil $08

main_loop:

    ld a, $1E
	rst.lil $08

    ; If the Escape key is pressed
    ld a, (ix + $0E)    
    bit 0, a
    jp nz, quit

    ; If the A key is pressed
    ld a, (ix + $08)    
    bit 1, a
    call nz, a_pressed


    ; If the D key is pressed
    ld a, (ix + $06)    
    bit 2, a
    call nz, d_pressed

    ; If the W key is pressed
    ld a, (ix + $04)
    bit 1, a
    call nz, w_pressed

    ; If the S key is pressed
    ld a, (ix + $0A)
    bit 1, a
    call nz, s_pressed

    ; If the S key is pressed
    ld a, (ix + $0C)
    bit 2, a
    call nz, space_pressed

    call vdu_vblank

    ; Loop back to the main program
    jp main_loop

    ; Quit the program
quit:
    ld hl,quit_msg
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

display_start_msg:
    ld hl, start_msg
    ld bc, 0
    ld a,0
    rst.lil $18
    ret

a_pressed:
    ld hl,a_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

d_pressed:
    ld hl,d_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

w_pressed:
    ld hl,w_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

s_pressed:
    ld hl,s_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

space_pressed:
    ld hl,space_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

vdu_vblank:        
    push ix            
    ld a, $08
	rst.lil $08
    ld a, (ix + $00 + 0)
wait:        
    cp a, (ix + $00 + 0)
    jr z, wait
    pop ix
    ret

start_msg:
    .db "Press A,W,S,D and space bar keys, Esc will quit...",13,10,0
quit_msg:
    .db 13,10,"Quitting...",13,10,0
a_msg:
    .db "A",0
d_msg:
    .db "D",0
w_msg:
    .db "W",0
s_msg:
    .db "S",0
space_msg:
    .db "SPACE",0