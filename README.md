# Agon Light 2 Development Environment Setup

![Discord](https://img.shields.io/discord/1158535358624039014)

This README.md and repository will assist you in setting up a development environment for the Agon Light 2 using the following tools:

- VSCode as an Integrated Development Environment
- Agon ez80asm for programming in Z80 assembly
- AgDev for programming in C
- Fab Agon emulator for testing

The repository has examples using both Z80 assembly and C. Each example has a README.md file that explains how to compile and run the example.

The guide is intended for people running on Linux using x86_64 platofrm and as such the binaries linked are for this architecture.  If you are running a differnet platform, such as arm64 then you will need to download the correct binaries for you platform.  If the correct binaries are not available for your platform you may need to build the tool yourself from source code.  At least one user has reported success following these instructions, but compiling the tools from source, on the arm64 platform.

### Install VSCode

Install VSCode and the following extensions:

- Makefile Tools : https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools

### Install agon-ez80asm

```
username@host:~$ cd ~
username@host:~$ mkdir -p development/tools/agon-ez80asm
username@host:~$ cd development/tools/agon-ez80asm
username@host:~$ wget https://github.com/envenomator/agon-ez80asm/releases/download/v1.8/ez80asm_linux_elf_x86_64.gz
username@host:~$ tar zxpvf ez80asm_linux_elf_x86_64.gz
username@host:~$ mv ez80asm_linux_elf_x86_64 ez80asm_linux_elf_x86_64.tar
username@host:~$ tar xpvf ez80asm_linux_elf_x86_64.tar
```
Add ez80asm bin to the path:

```
username@host:~$ vi ~/.profile
```

Add the following at the bottom of the file:

```
# set PATH so it includes agon-ez80asm if it exists
if [ -d "$HOME/development/tools/agon-ez80asm/bin" ] ; then
   PATH="$HOME/development/tools/agon-ez80asm/bin:$PATH"
fi
```

Test:

```
username@host:~$ source ~/.profile
username@host:~$ ez80asm -v
ez80asm version 1.8, (C)2024 - Jeroen Venema
```

### Install AgDev

```
username@host:~$ cd ~
username@host:~$ mkdir -p development/tools/
username@host:~$ wget https://github.com/CE-Programming/toolchain/releases/latest/download/CEdev-Linux.tar.gz
username@host:~$ tar zxpvf CEdev-Linux.tar.gz
username@host:~$ mv CEdev-Linux agdev
username@host:~$ cd development/tools/agdev
username@host:~$ wget https://github.com/pcawte/AgDev/releases/download/v3.0.0/AgDev_release_v3.0.0_linux.zip
username@host:~$ unzip AgDev_release_v3.0.0_linux.zip
Archive:  AgDev_release_v3.0.0_linux.zip
replace bin/convimg? [y]es, [n]o, [A]ll, [N]one, [r]ename: A
username@host:~$ rm AgDev_release_v3.0.0_linux.zip

```

Add agdev bin to the path:

```
username@host:~$ vi ~/.profile
```

Add the following at the bottom of the file:

```
# set PATH so it includes agdev if it exists
if [ -d "$HOME/development/tools/agdev/bin" ] ; then
   PATH="$HOME/development/tools/agdev/bin:$PATH"
fi
```

Test:

```
username@host:~$ source ~/.profile
username@host:~$ ez80-clang -v
clang version 15.0.0 (https://github.com/jacobly0/llvm-project 5f8512f22751066573aa48ac848a6d2195838ac3)
Target: ez80
Thread model: posix
InstalledDir: /home/username/development/tools/agdev/bin
```

### Install Fabulous Agon Emulator

```
username@host:~$ cd ~
username@host:~$ mkdir -p development/tools/
username@host:~$ cd development/tools/
username@host:~$ wget https://github.com/tomm/fab-agon-emulator/releases/download/0.9.57/fab-agon-emulator-v0.9.57-linux-x86_64.tar.bz2
username@host:~$ bunzip fab-agon-emulator-v0.9.57-linux-x86_64.tar.bz2
username@host:~$ tar xpvf fab-agon-emulator-v0.9.57-linux-x86_64.tar
username@host:~$ mv fab-agon-emulator-v0.9.57-linux-x86_64 fab-agon-emulator-v0.9.57
username@host:~$ ln -s fab-agon-emulator-v0.9.57 fab-agon
```

Add Fab Agon emulator to the path:

```
username@host:~$ vi ~/.profile
```

Add the following at the bottom of the file:

```
# set PATH so it includes Fab Agon if it exists
if [ -d "$HOME/development/tools/fab-agon" ] ; then
   PATH="$HOME/development/tools/fab-agon:$PATH"
fi
```

Test:

```
username@host:~$ source ~/.profile
username@host:~$ fab-agon-emulator --help
The Fabulous Agon Emulator!

USAGE:
  fab-agon-emulator [OPTIONS]

OPTIONS:
  -d, --debugger        Enable the eZ80 debugger
  -b, --breakpoint      Set a breakpoint before starting
...
```

### Build software!

You should now be able to build either the assembler or C programs in this repository.

### Where to get help

You can ask for help in the Agon and Console8 Community Discord channel, which can be found [here](https://discord.gg/JpncxCTA7s).

### Found this guide useful?

I don't write code, documents or software for profit, I do it for enjoyment and to help others. If you get anything useful from this guide, and only if you can afford it, please let me know by buying me a coffee using my Ko-fi tip page [here](https://ko-fi.com/andymccall).