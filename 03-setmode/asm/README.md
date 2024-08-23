### 03-setmoade

This program changes the screen mode.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/03-setmode/asm
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
Label memory  : 79
Labels        : 2

Macro memory  : 0
Macros        : 0

Input buffers : 833
---------------------
Total memory  : 912

Sources parsed: 1
Binfiles read : 0

Output size   : 145
mv src/main.bin bin/setmode.bin
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

setmode.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load setmode.bin
/ * run
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/03-setmode/assets/03-setmode_asm.png?raw=true)
