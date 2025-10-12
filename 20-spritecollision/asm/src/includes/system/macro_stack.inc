    MACRO macro_stack_push_all
        push af
        push bc
        push de
        push ix
        push iy
    ENDMACRO

    MACRO macro_stack_pop_all
        pop iy
        pop ix
        pop de
        pop bc
        pop af
    ENDMACRO