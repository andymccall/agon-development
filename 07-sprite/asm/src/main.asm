;
; Title:		       07-sprite
;
; Description:         An example of displaying and moving a sprite
;                      on the Agon Light 2    
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

SCREENMODE_320x240_64:   equ 8

start:
    push af
    push bc
    push de
    push ix
    push iy

    ld a, $08
    rst.lil $08

    call set_screen_mode

    call cursor_off

    ld hl,start_msg
    ld bc,0
    ld a,0
    rst.lil $18

    ld hl, VDUdata
    ld bc, endVDUdata - VDUdata
    rst.lil $18 

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

    call vdu_refresh

    ; Loop back to the main program
    jp main_loop

    ; Quit the program
quit:
    call hide_sprite
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

set_screen_mode:
	ld a, 22
	rst.lil $10
	ld a, SCREENMODE_320x240_64
	rst.lil $10
    ret

vdu_refresh:
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd:  db 23,27,15
@end:  db 0x00

cursor_off:    
    ld hl,@cmd
    ld bc,@end-@cmd
    rst.lil $18
    ret
@cmd:
    db 23,1,0
@end:

vdu_sprite_move_abs:
    ld (@sprite_x), bc
    ld (@sprite_y), de
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd:  db 23,27,13
@sprite_x: dw 0x0000
@sprite_y: dw 0x0000
@end:  db 0x00

vdu_vblank:        
    push ix            
    ld a, $08
	rst.lil $08
    ld a, (ix + $00 + 0)
@wait:        
    cp a, (ix + $00 + 0)
    jr z, @wait
    pop ix
    ret

d_pressed:
    ld a, (sprite_x)
    inc a
    ld (sprite_x), a
    ld bc,0
    ld c,a
    ld de,0
    ld a, (sprite_y)
    ld e, a
    call vdu_sprite_move_abs
    ret

a_pressed:
    ld a, (sprite_x)
    dec a
    ld (sprite_x), a
    ld bc,0
    ld c,a
    ld de,0
    ld a, (sprite_y)
    ld e, a
    call vdu_sprite_move_abs
    ret

w_pressed:
    ld a, (sprite_x)
    ld bc,0
    ld c,a
    ld de,0
    ld a, (sprite_y)
    dec a
    ld (sprite_y), a
    ld e, a
    call vdu_sprite_move_abs
    ret

s_pressed:
    ld a, (sprite_x)
    ld bc,0
    ld c,a
    ld de,0
    ld a, (sprite_y)
    inc a
    ld (sprite_y), a
    ld e, a
    call vdu_sprite_move_abs
    ret

space_pressed:
    ld hl,space_msg
    ld bc,0
    ld a,0
    rst.lil $18
    ret

hide_sprite:
    ld hl, @cmd
    ld bc, @end - @cmd
    rst.lil $18
    ret 
@cmd:
    .db 23, 27, 4, 0
    .db 23, 27, 12
@end:

start_msg:
    .db "Press A,W,S,D to move the zombie.",13,10,"Esc will quit...",13,10,0
quit_msg:
    .db 13,10,"Quitting...",13,10,0
space_msg:
    .db "SPACE",0

zombie:     EQU     0
sprite:     EQU     0
sprite_x:
     .db 150
sprite_y:
     .db 100

VDUdata:
    .db 23, 0, 192, 0

    .db 23, 27, 0, zombie
    .db 23, 27, 1
    .dw 16, 16
    incbin "src/zombie.data"

    .db 23, 27, 4, sprite
    .db 23, 27, 5
    .db 23, 27, 6, zombie
    .db 23, 27, 7, 1
    .db 23, 27, 11

    .db 23, 27, 4, sprite
    .db 23, 27, 13
    .dw 150, 100

endVDUdata: