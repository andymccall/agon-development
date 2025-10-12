; Name: keyboard_wait_for_release
; Description: Waits for a single key to be released
; Notes:
;
; Inputs:
keyboard_wait_for_release:

	ld	a, mos_sysvars      ; get IX pointer to sysvars
	rst.lis	$08

    ld a, (ix + $18)        ; get key state
    cp 0                    ; are keys up, none currently pressed?
    jr nz, keyboard_wait_for_release

    ret