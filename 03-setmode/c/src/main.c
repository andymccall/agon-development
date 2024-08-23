/* 
/ Title:		      03-setmode - C Example
/
/ Description:    A program that sets the screen mode on the Agon Light 2
/
/ Author:		   Andy McCall, mailme@andymccall.co.uk
/
/ Created:		   2024-08-23 @ 14:51
/ Last Updated:	2024-08-23 @ 14:51
/
/ Modinfo:
*/

#include <stdio.h>
#include <agon/vdp_vdu.h>

int main(void) {

   vdp_mode(8);
   printf("Changed screen mode to 320x240x64!\n");

   return 0;

}
