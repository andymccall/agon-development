; CREDIT: Code from Richard Turnnidge's assembly port of my Number Guess game
; TODO: study this code and understand how it works, rewrite in my own style
number_print_dec:               ; print unsigned HL (0..16,777,215) as decimal

    push af
    push bc
    push de

    ld b, 0                    ; track when output has started

    ld de, 10000000
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 1000000
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 100000
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 10000
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 1000
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 100
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 10
    call number_print_calc_digit
    call number_print_emit_digit

    ld de, 1
    call number_print_calc_digit
    add a, '0'
    rst.lil $10

    pop de
    pop bc
    pop af
    ret

number_print_emit_digit:
    cp 0
    jr nz, number_print_emit_non_zero
    ld a, b
    or a
    ret z
    ld a, 0
    jr number_print_emit_output

number_print_emit_non_zero:
    ld b, 1

number_print_emit_output:
    add a, '0'
    rst.lil $10
    ret

number_print_calc_digit:
    ld c, 0

number_print_calc_loop:
    xor a                     ; clear carry before subtract
    sbc hl, de
    jr c, number_print_calc_done
    inc c
    jr number_print_calc_loop

number_print_calc_done:
    add hl, de                ; undo last subtract
    ld a, c
    ret