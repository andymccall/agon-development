### getkeys

This program prints Hello, World! to the console.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/getkeys/asm
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
mv src/main.bin bin/getkeys.bin
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

getkeys.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load getkeys.bin
/ * run
Hello, World!
```
