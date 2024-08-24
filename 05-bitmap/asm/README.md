### 05-bitmap

This program prints a bitmap to the screen.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/bitmap/asm
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
Label memory  : 251
Labels        : 6

Macro memory  : 0
Macros        : 0

Input buffers : 2899
---------------------
Total memory  : 3150

Sources parsed: 1
Binfiles read : 2

Output size   : 1159
mv src/main.bin bin/bitmap.bin
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

bitmap.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load bitmap.bin
/ * run
```


You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/05-bitmap/assets/05-bitmap_asm.png?raw=true)