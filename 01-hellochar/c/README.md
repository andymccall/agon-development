### 01-hellochar

This program prints a character to the console.

#### Building

Perform the following commands to compile the project:

```

username@host:~$ cd agon-development/01-hellochar/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/hellochar.bin
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

hellochar.bin hellochar.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load hellochar.bin
/ * run
A

Okay
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/01-hellochar/assets/01-hellochar.png?raw=true)
