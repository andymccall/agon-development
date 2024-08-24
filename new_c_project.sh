#!/usr/bin/env bash

echo -n "Creating new C project..."
mkdir -p $1
mkdir -p $1/c
mkdir -p $1/c/src

cat > $1/c/Makefile << 'EOF'
# ----------------------------
# Makefile Options
# ----------------------------

NAME               = C_PROGRAM_VARIABLE
cat >> $1/c/Makefile << 'EOF'
FAB_AGON_EMU       = fab-agon-emulator
FAB_AGON_EMU_FLAGS = --vdp ~/development/tools/fab-agon/firmware/vdp_console8.so --mos ~/development/tools/fab-agon/firmware/mos_console8.bin --sdcard bin/

CFLAGS = -Wall -Wextra -Oz
CXXFLAGS = -Wall -Wextra -Oz

include $(shell cedev-config --makefile)

run:
	@echo "Launching emulator..."
	$(FAB_AGON_EMU) $(FAB_AGON_EMU_FLAGS) 
EOF
sed -i -e s/C_PROGRAM_VARIABLE/${1}/g $1/c/Makefile

cat > $1/c/src/main.c << EOF
/* 
/ Title:		      ${1}
/
/ Description:
/
/ Author:
/
/ Created:		   $(date)
/ Last Updated:	   
/
/ Modinfo:
*/

#include <stdio.h>

int main(void) {

   printf("Hello, World!\n");

   return 0;

}
EOF

cat > $1/c/README.md << 'EOF'
### C_PROGRAM_VARIABLE

This program changes the screen mode.

#### Building

Perform the following commands to compile the project:

```

username@host:~$ cd agon-development/C_PROGRAM_VARIABLE/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/C_PROGRAM_VARIABLE.bin
```

#### Running the program

The newly built program can be run within the Fab Emulator using the following commands:

```
username@host:~$ make run
```

This will launch the Fab emulator.  Once the emulator has started check the binary is accessible to the emulator by using the dir command:

```
/ *dir
Volume: hostfs
Directory: /

C_PROGRAM_VARIABLE.bin C_PROGRAM_VARIABLE.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load C_PROGRAM_VARIABLE.bin
/ * run
```
EOF
sed -i -e s/C_PROGRAM_VARIABLE/${1}/g $1/c/README.md

echo "Done!"
echo ""
echo "Your C project is now available in the directory ${1}."
echo "Please follow ${1}/c/README.md to build and run program."