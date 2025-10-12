vdu_game_data:

; Pac-Man

    macro_bitmap_make_buffered SPRITE_PAC_MAN_00_00, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_00_00.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_00_01, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_00_01.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_00_02, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_00_02.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_01_00, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_01_00.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_01_01, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_01_01.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_01_02, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_01_02.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_02_00, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_02_00.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_02_01, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_02_01.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_02_02, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_02_02.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_03_00, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_03_00.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_03_01, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_03_01.rgba2"
    macro_bitmap_make_buffered SPRITE_PAC_MAN_03_02, SPRITE_PAC_MAN_WIDTH, SPRITE_PAC_MAN_HEIGHT, "src/assets/pac_man/pac_man_03_02.rgba2"

    macro_sprite_select_sprite SPRITE_PAC_MAN_ID
    macro_sprite_clear_current

    macro_sprite_add_frame SPRITE_PAC_MAN_00_00
    macro_sprite_add_frame SPRITE_PAC_MAN_00_01
    macro_sprite_add_frame SPRITE_PAC_MAN_00_02
    macro_sprite_add_frame SPRITE_PAC_MAN_01_00
    macro_sprite_add_frame SPRITE_PAC_MAN_01_01
    macro_sprite_add_frame SPRITE_PAC_MAN_01_02
    macro_sprite_add_frame SPRITE_PAC_MAN_02_00
    macro_sprite_add_frame SPRITE_PAC_MAN_02_01
    macro_sprite_add_frame SPRITE_PAC_MAN_02_02
    macro_sprite_add_frame SPRITE_PAC_MAN_03_00
    macro_sprite_add_frame SPRITE_PAC_MAN_03_01
    macro_sprite_add_frame SPRITE_PAC_MAN_03_02

    macro_sprite_activate 1

    macro_sprite_move SPRITE_PAC_MAN_ID, 250,248

vdu_game_data_end: