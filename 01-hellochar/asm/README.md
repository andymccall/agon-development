### 01-hellochar

This program prints a character to the console.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/01-hellochar/asm
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

Input buffers : 695
---------------------
Total memory  : 733

Sources parsed: 1
Binfiles read : 0

Output size   : 92
mv src/main.bin bin/hellochar.bin
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

hellochar.bin
```

Then run the binary using by loading it and issuing the run command:

```
/ * load hellochar.bin
/ * run
A
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/01-hellochar/assets/01-hellochar_asm.png?raw=true)
