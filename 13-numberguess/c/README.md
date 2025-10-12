### numberguess

This program changes the screen mode.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/13-numberguess/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/numberguess.bin
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

numberguess.bin numberguess.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load numberguess.bin
/ * run
```
