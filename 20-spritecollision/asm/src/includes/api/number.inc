; CREDIT: Code from Richard Turnnidge's assembly port of my Number Guess game
; TODO: study this code and understand how it works, rewrite in my own style
number_print_dec:               ; debug A to screen as 3 char string pos

    push af
    ld a, 48
    ld (answer),a 
    ld (answer+1),a 
    ld (answer+2),a     ; reset to default before starting

                        ; is it bigger than 200?
    pop af

    ld (base),a         ; save

    cp 200
    jr c,_under200      ; not 200+
    sub a, 200
    ld (base),a         ; sub 200 and save

    ld a, 50            ; 2 in ascii
    rst.lil $10         ; print out a '200' digit
    ld (answer),a
    jr _under100

_under200:
    cp 100
    jr c,_under100      ; not 200+
    sub a, 100
    ld (base),a         ; sub 200 and save

    ld a, 49            ; 1 in ascii
    ld (answer),a
 
    rst.lil $10         ; print out a '100' digit
    jr _under100


_under100:
    ld a, (base)
    ld c,a
    ld d, 10
    call C_Div_D

    add a, 48
    ld (answer + 2),a
    ld b, a 

    ld a, c
    cp 0
    jr z, _lastDigit

    add a, 48
    ld (answer + 1),a
    rst.lil $10         ; print out 10s digit
_lastDigit:
    ld a,b 
    rst.lil $10         ; print out last digit

    ret 

answer:         .db     "000"       ; string to output

base:           .db     0       ; used in calculations

C_Div_D:
;Inputs:
;     C is the numerator
;     D is the denominator
;Outputs:
;     A is the remainder
;     B is 0
;     C is the result of C/D
;     D,E,H,L are not changed
;
    ld b,8
    xor a
    sla c
    rla
    cp d
    jr c,$+4
    inc c
    sub d
    djnz $-8
    ret