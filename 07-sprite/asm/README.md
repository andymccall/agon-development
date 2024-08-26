### 07-sprite

This program displays and moves a sprite around the screen.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/07-sprite/asm
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
Label memory  : 1595
Labels        : 35

Macro memory  : 0
Macros        : 0

Input buffers : 5006
---------------------
Total memory  : 6601

Sources parsed: 1
Binfiles read : 2

Output size   : 1581
mv src/main.bin bin/sprite.bin
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

sprite.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load sprite.bin
/ * run
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/07-sprite/assets/07-sprite_asm.png?raw=true)

The A,S,W,D keys will move the zombie around the screen.  The escape key will quit the program.