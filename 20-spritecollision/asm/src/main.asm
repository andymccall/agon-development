;
; Title:		   20-spritecollision - Assembler Example
;
; Description:     A program that shows how to handle sprite
;                  collision on the Agon Light 2
; Author:		   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   2025-10-09 @ 19:54
; Last Updated:	   2025-10-09 @ 17:54
;
; Modinfo:
;

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

; API includes
    include "src/includes/system/mos_api.inc"
    include "src/includes/system/macro_stack.inc"
    include "src/includes/api/vdu.inc"
    include "src/includes/api/vdu_screen.inc"
    include "src/includes/api/vdu_cursor.inc"
    include "src/includes/api/vdu_buffer.inc"
    include "src/includes/api/vdu_bitmap.inc"
    include "src/includes/api/vdu_plot.inc"
    include "src/includes/api/vdu_text.inc"
    include "src/includes/api/vdu_color.inc"
    include "src/includes/api/sprite.inc"
    include "src/includes/api/vdu_sprite.inc"
    include "src/includes/api/keyboard.inc"
    include "src/includes/api/macro_sprite.inc"
    include "src/includes/api/macro_text.inc"
    include "src/includes/api/macro_bitmap.inc"

; Game includes
    include "src/includes/game/globals.inc"
    include "src/includes/game/vdu_game_data.inc"

; Character Sprites
    include "src/includes/game/sprites/pac_man.inc"

start:

    macro_stack_push_all

    call vdu_buffer_clear_all

    ld a, VDU_MODE_512x384x64_60HZ
    call vdu_screen_set_mode

    ld a, VDU_SCALING_OFF
    call vdu_screen_set_scaling

    call vdu_cursor_off

    ; Determine screen bounds and compute maximum sprite coordinates
    ; max_x = screen_width  - SPRITE_PAC_MAN_WIDTH
    ; max_y = screen_height - SPRITE_PAC_MAN_HEIGHT
    ld a, mos_sysvars
    rst.lil $08                ; IX -> sysvars
    ld l, (ix + sysvar_scrWidth)
    ld h, (ix + sysvar_scrWidth + 1)
    ld de, SPRITE_PAC_MAN_WIDTH
    or a                       ; clear carry
    sbc hl, de
    ld (max_x), hl

    ld l, (ix + sysvar_scrHeight)
    ld h, (ix + sysvar_scrHeight + 1)
    ld de, SPRITE_PAC_MAN_HEIGHT
    or a
    sbc hl, de
    ld (max_y), hl

    ; Load the VDU data for the game sprites and tiles
    ld hl, vdu_game_data
    ld bc, vdu_game_data_end - vdu_game_data
    rst.lil VDU_OUTPUT_TO_VDP

    ld hl, game_msg
    call vdu_text_print

    ld a, SPRITE_COUNT
    call vdu_sprite_activate

    ld a, SPRITE_PAC_MAN_ID
    call vdu_sprite_select
    call vdu_sprite_show

    ld a, VDU_COL_BRIGHT_RED
    call vdu_plot_set_fill
    ld bc, 100
    ld de, 200
    ld ix, 200
    ld iy, 220
    call vdu_plot_filled_rect

game_loop:

    call vdu_vblank

    call vdu_refresh

    call handle_input

    jp game_loop

quit:

    ld hl, VDU_MODE_640x480x4_60HZ
    call vdu_screen_set_mode

    call vdu_cursor_flash

    ld hl, quit_msg
    call vdu_text_print

    macro_stack_pop_all

    ld hl,0

    ret

handle_input:
    ld a, mos_getkbmap
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

    ret

; Move left...
d_pressed:
    ld a, SPRITE_PAC_MAN_ID
    call vdu_sprite_select
    ld a, 0
    call vdu_sprite_select_frame

    ; HL = sprite_x (clear upper byte first for ADL safety)
    ld hl, 0
    ld a, (sprite_x)
    ld l, a
    ld a, (sprite_x + 1)
    ld h, a

    ; If X > 496, skip (compare against 385 for strict '>')
    push hl
    ld de, 496            ; 0x0181
    or a                  ; clear carry
    sbc hl, de            ; HL - 496 (24-bit in ADL)
    pop hl
    jp nc, d_pressed_end  ; HL >= 496 -> skip increment

    ; X <= 496 -> increment candidate
    inc hl

    ; Candidate BC = X (from HL), DE = Y (from memory)
    ld c, l
    ld b, h
    ld a, (sprite_y)
    ld e, a
    ld a, (sprite_y + 1)
    ld d, a

    ; Check collision at candidate position; Carry set => collision
    call detect_collision
    jp c, d_pressed_end   ; collision -> skip store/move

    call detect_bounds
    jp c, d_pressed_end

    ; No collision -> store back new X and move
    ld a, c
    ld (sprite_x), a
    ld a, b
    ld (sprite_x + 1), a

    call vdu_sprite_move_abs
d_pressed_end:
    ret

; Move right...
a_pressed:
    ld a, SPRITE_PAC_MAN_ID
    call vdu_sprite_select
    ld a, 3
    call vdu_sprite_select_frame

    ; HL = sprite_x (clear upper byte first for ADL safety)
    ld hl, 0
    ld a, (sprite_x)
    ld l, a
    ld a, (sprite_x + 1)
    ld h, a

    ; If X == 0, skip decrement (top-left origin)
    ld a, h
    or l
    jp z, a_pressed_end

    ; X > 0 -> decrement candidate
    dec hl

    ; Candidate BC = X (from HL), DE = Y (from memory)
    ld c, l
    ld b, h
    ld a, (sprite_y)
    ld e, a
    ld a, (sprite_y + 1)
    ld d, a

    ; Check collision at candidate position; Carry set => collision
    call detect_collision
    jp c, a_pressed_end   ; collision -> skip store/move

    call detect_bounds
    jp c, a_pressed_end

    ; No collision -> store back new X and move
    ld a, c
    ld (sprite_x), a
    ld a, b
    ld (sprite_x + 1), a

    call vdu_sprite_move_abs
a_pressed_end:
    ret

; Move up...
w_pressed:
    ld a, SPRITE_PAC_MAN_ID
    call vdu_sprite_select
    ld a, 7
    call vdu_sprite_select_frame

    ; BC = X from memory
    ld a, (sprite_x)
    ld c, a
    ld a, (sprite_x + 1)
    ld b, a

    ; HL = Y from memory
    ld a, (sprite_y)
    ld l, a
    ld a, (sprite_y + 1)
    ld h, a

    ; If Y <= 0, skip decrement (bytewise, ADL-safe)
    ld a, h
    or l
    jp z, w_pressed_end

    ; Candidate DE = Y-1 from (HL-1), BC = X from memory
    dec hl
    ld e, l
    ld d, h

    ; Check collision at candidate position; Carry set => collision
    call detect_collision
    jp c, w_pressed_end   ; collision -> skip store/move

    call detect_bounds
    jp c, w_pressed_end

    ; No collision -> store back new Y and move
    ld a, e
    ld (sprite_y), a
    ld a, d
    ld (sprite_y + 1), a

    call vdu_sprite_move_abs
w_pressed_end:
    ret

; Move down...
s_pressed:
    ld a, SPRITE_PAC_MAN_ID
    call vdu_sprite_select
    ld a, 10
    call vdu_sprite_select_frame

    ; BC = X from memory (16-bit)
    ld a, (sprite_x)
    ld c, a
    ld a, (sprite_x + 1)
    ld b, a

    ; HL = Y (clear upper first for ADL safety)
    ld hl, 0
    ld a, (sprite_y)
    ld l, a
    ld a, (sprite_y + 1)
    ld h, a

    ; If Y >= 368 (0x0170), skip increment
    push hl
    ; DE = 0x0170 with upper byte zeroed for ADL-safe SBC
    ld de, 0
    ld e, 112          ; low byte = 0x70 (112)
    ld d, 1            ; high byte = 0x01
    or a               ; clear carry
    sbc hl, de         ; HL - 368
    pop hl
    jp nc, s_pressed_end   ; Y >= 368 -> skip

    ; Y < 368 -> increment candidate (move down)
    inc hl

    ; Candidate DE = Y (from HL), BC = X from memory (already loaded)
    ld e, l
    ld d, h

    ; Check collision at candidate position; Carry set => collision
    call detect_collision
    jp c, s_pressed_end   ; collision -> skip store/move

    call detect_bounds
    jp c, s_pressed_end

    ; No collision -> store back new Y and move
    ld a, e
    ld (sprite_y), a
    ld a, d
    ld (sprite_y + 1), a

    call vdu_sprite_move_abs
s_pressed_end:
    ret

detect_collision:
    ; Inputs: BC = candidate X, DE = candidate Y
    ; Outputs: Carry set on collision, Carry clear on no collision
    ; Clobbers: AF, HL, DE (restored), BC (restored)

    push bc
    push de

    ; 1) If (X + 16) <= 100 -> no overlap
    ld hl, 0             ; clear upper for ADL safety
    ld l, c
    ld h, b
    ld de, 16
    add hl, de            ; HL = X + 16
    ld de, 0
    ld e, 100            ; left edge of block
    or a                  ; clear carry
    sbc hl, de            ; (X+16) - 100
    jr c, no_collision   ; X+16 < 100 -> no overlap
    jr z, no_collision   ; X+16 == 100 -> no overlap (touching at edge)

    ; 2) If X >= 200 -> no overlap (right edge of block)
    ld hl, 0
    ld l, c
    ld h, b               ; HL = X
    ld de, 0
    ld e, 200            ; right edge of block
    or a
    sbc hl, de            ; X - 200
    jr nc, no_collision  ; X >= 200 -> no overlap

    ; 3) If (Y + 16) <= 200 -> no overlap (top edge of block)
    pop hl                ; HL = saved candidate Y
    push hl               ; re-save Y to maintain stack
    ld de, 0
    ld e, 16
    add hl, de            ; HL = Y + 16
    ld de, 0
    ld e, 200            ; top edge of block
    or a
    sbc hl, de            ; (Y+16) - 200
    jr c, no_collision   ; Y+16 < 200 -> no overlap
    jr z, no_collision   ; Y+16 == 200 -> no overlap

    ; 4) If Y >= 220 -> no overlap (bottom edge of block)
    pop hl                ; HL = saved candidate Y
    push hl               ; re-save Y to maintain stack
    ld de, 0
    ld e, 220
    or a
    sbc hl, de            ; Y - 220
    jr nc, no_collision  ; Y >= 220 -> no overlap

    ; Overlaps in both axes -> collision
    pop de
    pop bc
    scf                   ; set carry to indicate collision
    ret

no_collision:
    pop de
    pop bc
    or a                  ; clear carry to indicate no collision
    ret

detect_bounds:
    push bc
    push de

no_bounds:
    pop de
    pop bc
    or a                  ; clear carry to indicate no collision
    ret

game_msg:
    .db "Press A,W,S,D to move Pac-Man.",13,10,"Esc will quit...",13,10,0

quit_msg:
    .db "Thank you for playing!",13,10,0

sprite:         EQU     0
sprite_x:
     .dw 250
sprite_y:
     .dw 248

max_x:
    .dw 0
max_y:
    .dw 0