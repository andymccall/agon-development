;
; Title:		          10-macros
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

	macro TAB_TO x,y
	ld a, 31					; move to...
	rst.lil $10
	ld a, x						; X position
	rst.lil $10
	ld a, y						; Y position
	rst.lil $10
	endmacro

    macro MAKEBUFFEREDCELL64K screenId, id, width, height, data
    .db 23,0,$A0
    .dw screenId*256+id
    endmacro

start:
    push af
    push bc
    push de
    push ix
    push iy

    TAB_TO 10,10
    ld hl,hello_msg
    ld bc,0
    ld a,0
    rst.lil $18

    MAKEBUFFEREDCELL64K 250, 0, 16, 16, "src/data/pac-man.rgba"

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret

hello_msg:
    .db "Hello, World!",13,10,0
