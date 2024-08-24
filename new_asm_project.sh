#!/usr/bin/env bash

echo -n "Creating new assmebly project..."
mkdir -p $1
mkdir -p $1/asm
mkdir -p $1/asm/src

cat > $1/asm/Makefile << 'EOF'
# ----------------------------
# Makefile Options
# ----------------------------

EZ80ASM            = ez80asm
EZ80ASM_FLAGS      = -x
RM                 = rm -f
FAB_AGON_EMU       = fab-agon-emulator
FAB_AGON_EMU_FLAGS = --vdp ~/development/tools/fab-agon/firmware/vdp_console8.so --mos ~/development/tools/fab-agon/firmware/mos_console8.bin --sdcard bin/

default: all

all:
	@echo "Building project..."
	mkdir -p bin
	$(EZ80ASM) $(EZ80ASM_FLAGS) src/main.asm
	mv src/main.bin bin/ASM_PROGRAM_VARIABLE.bin

clean:
	@echo "Cleaning project..."
	rm -rf bin
	rm -rf src/*.bin
	
run:
	@echo "Launching emulator..."
	$(FAB_AGON_EMU) $(FAB_AGON_EMU_FLAGS) 
EOF
sed -i -e s/ASM_PROGRAM_VARIABLE/${1}/g $1/asm/Makefile

cat > $1/asm/src/main.asm << 'EOF'
;
; Title:		          ASM_PROGRAM_VARIABLE
;
; Description:         
;
; Author:
;
; Created:		       ${date}
; Last Updated:
;
; Modinfo:

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

start:
    push af
    push bc
    push de
    push ix
    push iy

    ld hl,hello_msg
    ld bc,0
    ld a,0
    rst.lil $18

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret

hello_msg:
    .db "Hello, World!",13,10,0
EOF
sed -i -e s/ASM_PROGRAM_VARIABLE/${1}/g $1/asm/src/main.asm


cat > $1/asm/README.md << 'EOF'
### ASM_PROGRAM_VARIABLE

This program prints Hello, World! to the console.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/ASM_PROGRAM_VARIABLE/asm
username@host:~$ make
Building project...
mkdir -p bin
ez80asm -x src/main.asm
Assembling src/main.asm
Pass 1...
Pass 2...
Done in 0.00 seconds

Assembly statistics
======================
Label memory  : 80
Labels        : 2

Macro memory  : 0
Macros        : 0

Input buffers : 850
---------------------
Total memory  : 930

Sources parsed: 1
Binfiles read : 0

Output size   : 116
mv src/main.bin bin/ASM_PROGRAM_VARIABLE.bin
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

ASM_PROGRAM_VARIABLE.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load ASM_PROGRAM_VARIABLE.bin
/ * run
Hello, World!
```
EOF
sed -i -e s/ASM_PROGRAM_VARIABLE/${1}/g $1/asm/README.md

echo "Done!"
echo ""
echo "Your assembly project is now available in the directory ${1}."
echo "Please follow ${1}/asm/README.md to build and run program."