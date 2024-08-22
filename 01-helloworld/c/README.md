### 01-helloworld

This program prints Hello, World! to the console.

#### Building

Perform the following commands to compile the project:

```

username@host:~$ cd agon-development/01-helloworld/c
username@host:~$ make
[compiling] src/main.c
[lto opt] obj/lto.bc
[linking] bin/helloworld.bin
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

helloworld.bin helloworld.map
```

Then run the binary using by loading it and issuing the run command:

```
/ * load helloworld.bin
/ * run
Hello, World!

Okay
```

You should see something similar to the following:

![Screenshot of the Fab Emulator](https://github.com/andymccall/agon-development/blob/main/01-helloworld/assets/01-helloworld_c.png?raw=true)
