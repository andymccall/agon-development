/* 
/ Title:		  04-setscreen - C Example
/
/ Description:    A program that sets the screen color on the Agon Light 2
/
/ Author:		  Andy McCall, mailme@andymccall.co.uk
/
/ Created:		  2024-08-23 @ 14:51
/ Last Updated:	  2024-08-23 @ 14:51
/
/ Modinfo:
*/

#include <stdio.h>
#include <agon/vdp_vdu.h>

#define COLOR_RED           1
#define COLOR_BLACK         0

void set_bg_color(int COLOR) {
    vdp_set_text_colour(COLOR+128);
    return;
}

void set_fg_color(int COLOR) {
    vdp_set_text_colour(COLOR);
    return;
}

int main(void) {

    set_fg_color(COLOR_BLACK);
    set_bg_color(COLOR_RED);
    vdp_clear_screen();
    printf("Set the screen color to red!\n");

    return 0;

}
