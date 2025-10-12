;
; Title:		          gameloop
;
; Description:         
;
; Author:
;
; Created:		       ${date}
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

main_loop:

    ld a, $1E
	rst.lil $08

    ; If the Escape key is pressed
    ld a, (ix + $0E)    
    bit 0, a
    jp nz, quit

    call vdu_vblank

    call vdu_refresh

; Display 1 every frame
; 1/60
	ld a, 31
	rst.lil $10
	ld a, 1
	rst.lil $10
	ld a, 1
	rst.lil $10

    ld hl,msg_1
    ld bc,0
    ld a,0
    rst.lil $18

; Display 1 second frame
; 2/60
	ld a, 31
	rst.lil $10
	ld a, 3
	rst.lil $10
	ld a, 1
	rst.lil $10

    ld a, (tick_60)             ; load tick_60 into a
    cp 1
    jp z, print_1_60
    
    ld hl,msg_0
    ld bc,0
    ld a,0
    rst.lil $18
    
    inc a

    jp end_60        

print_1_60:

    ld hl,msg_1
    ld bc,0
    ld a,0
    rst.lil $18

    ld a, 0

end_60:
    ld (tick_60), a             ; put a into tick_60


; Display 1 every third frame
; 


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

cursor_off:    
    ld hl,@cmd
    ld bc,@end-@cmd
    rst.lil $18
    ret
@cmd:
    db 23,1,0
@end:

start_msg:
    .db "Game loop!",13,10,0
quit_msg:
    .db 13,10,"Quitting...",13,10,0

msg_0:
    .db "0",13,10,0

msg_1:
    .db "1",13,10,0

tick_60:
    .db 0
tick_30:
    .db 0
