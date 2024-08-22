### 00-firstprg

This program does nothing other than start and stop.  It's intended to test your development environment.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/00-firstprg/asm
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
Label memory  : 38
Labels        : 1

Macro memory  : 0
Macros        : 0

Input buffers : 709
---------------------
Total memory  : 747

Sources parsed: 1
Binfiles read : 0

Output size   : 88
mv src/main.bin bin/firstprg.bin
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

firstprg.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load firstprg.bin
/ * run
/ * 
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/00-firstprg/assets/01-firstprg_asm.png?raw=true)
