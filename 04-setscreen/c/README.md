### 04-setscreen

This program changes the screen color.

#### Building

Perform the following commands to compile the project:

```

username@host:~$ cd agon-development/04-setscreen/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/setscreen.bin
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

setscreen.bin setscreen.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load setscreen.bin
/ * run
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/04-setscreen/assets/04-setscreen_c.png?raw=true)
