; VDU 23, 27, 4, n: Select sprite n
; inputs: a is the 8-bit sprite id
vdu_sprite_select:
    ld (@sprite),a        
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd:    db 23,27,4
@sprite: db 0x00
@end:

; VDU 23, 27, 7, n: Activate n sprites
; inputs: a is the number of sprites to activate
; prerequisites: each sprite activated must have at least one frame attached to it
vdu_sprite_activate:
    ld (@num),a        
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd: db 23,27,7
@num: db 0x00
@end:

; VDU 23, 27, 8: Select next frame of current sprite
; inputs: none
; prerequisites: vdu_sprite_select
vdu_sprite_next_frame:
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd: db 23,27,8
@end:

; Name: vdu_sprite_show
; Description: Show the currently selected sprite
; Note: The sprite must be selected prior to calling this command using vdu_sprite_select
; URL: https://agonconsole8.github.io/agon-docs/vdp/Bitmaps-API/#sprites
;
; Inputs: None
;
vdu_sprite_show:
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd: db 23,27,11
@end:

; Name: vdu_sprite_hide
; Description: Hide the currently selected sprite
; Note: The sprite must be selected prior to calling this command using vdu_sprite_select
; URL: https://agonconsole8.github.io/agon-docs/vdp/Bitmaps-API/#sprites
;
; Inputs: None
;
vdu_sprite_hide:
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd: db 23,27,12
@end:

; VDU 23, 27, 10, n: Select the nth frame of current sprite
; inputs: a is frame number to select
; prerequisites: vdu_sprite_select
vdu_sprite_select_frame:
    ld (@frame),a        
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd:    db 23,27,10
@frame:  db 0x00
@end:

; Name: vdu_sprite_move_abs
; Description: Move the current sprite to an absolute position
; Note:
; URL:
;
; Inputs: bc is x coordinate, de is y coordinate
;
vdu_sprite_move_abs:
    ; Store X (BC) as 16-bit little-endian using HL pointer (ADL-safe)
    ld hl, @sprite_x
    ld (hl), c
    inc hl
    ld (hl), b
    ; Store Y (DE)
    ld hl, @sprite_y
    ld (hl), e
    inc hl
    ld (hl), d
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd:  db 23,27,13
@sprite_x: dw 0x0000
@sprite_y: dw 0x0000
@end:  db 0x00

; VDU 23, 27, 14, x; y;: Move current sprite by x, y pixels
; inputs: bc is x coordinate, de is y coordinate
; prerequisites: vdu_sprite_select
vdu_sprite_move_rel:
    ; Store signed deltas using HL pointer (ADL-safe)
    ld hl, @dx
    ld (hl), c
    inc hl
    ld (hl), b
    ld hl, @dy
    ld (hl), e
    inc hl
    ld (hl), d
    ld hl,@cmd         
    ld bc,@end-@cmd    
    rst.lil $18         
    ret
@cmd: db 23,27,14
@dx:  dw 0x0000
@dy:  dw 0x0000
@end: db 0x00 ; padding