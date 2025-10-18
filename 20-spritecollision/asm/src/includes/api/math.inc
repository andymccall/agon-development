; Name: math_greater_than
; Description: Sets Carry if the value in HL is greater than the value in DE
; Note:
; URL: 
;
; Inputs: hl, number to check
;         de, number to compare against
; Returns: Carry set when HL > DE, clear otherwise
; Destroys: Flags
math_greater_than:
    push af              ; keep caller’s accumulator/flags

    ld a,h
    cp d
    jr c, math_gt_not_greater  ; H < D -> not greater
    jr nz, math_gt_greater     ; H > D -> greater

    ld a,l               ; high bytes equal, compare low
    cp e
    jr c, math_gt_not_greater
    jr nz, math_gt_greater

math_gt_equal:
    pop af               ; restore caller’s AF
    or a                 ; clear carry, preserve A
    ret

math_gt_greater:
    pop af
    scf                  ; set carry to report “greater”
    ret

math_gt_not_greater:
    pop af
    or a                 ; clear carry (also covers equality)
    ret

; Name: math_less_than
; Description: Sets Carry if the value in HL is less than the value in DE
; Note:
; URL: 
;
; Inputs: hl, number to check
;         de, number to compare against
; Returns: Carry set when HL < DE, clear otherwise
; Destroys: Flags
math_less_than:
    push af              ; keep caller’s accumulator/flags

    ld a,h
    cp d
    jr c, math_lt_less   ; H < D -> definitely less
    jr nz, math_lt_not_less

    ld a,l               ; high bytes equal, compare low byte
    cp e
    jr c, math_lt_less
    jr z, math_lt_equal

math_lt_not_less:
    pop af
    or a                 ; clear carry, report not-less-or-equal
    ret

math_lt_equal:
    pop af
    or a                 ; equality -> clear carry
    ret

math_lt_less:
    pop af
    scf                  ; set carry to report "less than"
    ret