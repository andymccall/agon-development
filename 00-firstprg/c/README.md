### 00-firstprg

This program does nothing other than start and stop.  It's intended to test your development environment.

#### Building

Perform the following commands to compile the project:

```
username@host:~$ cd agon-development/00-firstprg/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/firstprg.bin
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

firstprg.bin firstprg.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load firstprg.bin
/ * run

Okay
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/00-firstprg/assets/00-firstprg_c.png?raw=true)
