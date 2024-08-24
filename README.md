# Agon Light 2 Development Environment Setup

## Intro

![Agon Light 2 Header](https://github.com/andymccall/agon-development/blob/main/assets/header.jpg?raw=true)

AgonLight2 is a re-design of the original Open Source Hardware design of AgonLight made by Bernardo Kastrup a.k.a. TheByteAttic. The firmware is developed by Dean Belfield. AgonLight2 is not a emulator, it uses modern ez80 processor which is new improved version of the classic Z80 which can address up to 16MB of memory (24 bit address bus) and runs at 20Mhz! ESP32-PICO-D4 is used as sound and graphics co-processor. The micro SD card acts like disk drive where you can load and save programs, write and read data. UEXT and GPIO ports allow AgonLight to interface outside world with digital Inputs, outputs, SPI, I2C, and UART. LiPo battery charger allows the whole computer to run for hours on single LiPo battery even if no external power supply is present. Color VGA output supports 320x200 64 colors, 512x384 16 colors, 640x480 16 colors, 1024x768 2 colors. AgonLight2 combines retro with modern, you can do old school games and at the same time you can do also small home automation jobs, attaching different sensors and relays to the UEXT/GPIO ports.

## Features

AgonLight2 has these features:

* eZ80 processor with 128KB flash 8KB SRAM
* 512KB external SRAM
* ESP32-D4-PICO co-processor for IO
* VGA output
* USB/PS2 keyboard
* MicroSD card connector
* Li-Po battery charger and step-up converter
* UEXT connector
* GPIO 34-pin connector
*  6 mount holes
* Dimensions: (106 x 65) mm

The Agon is available as a bare single board computer:

![Agon Light 2 Single Board Computer](https://github.com/andymccall/agon-development/blob/main/assets/agonlight2.jpg?raw=true)

Boxed in a nice case:

![Agon Light 2 Boxed](https://github.com/andymccall/agon-development/blob/main/assets/agonlight2-boxed.jpg?raw=true)

There's an Agon Origins Edition that's fully compatible, but based on an earlier design, which is available as a bare single board computer:

![Agon Origins Edition Single Board Computer](https://github.com/andymccall/agon-development/blob/main/assets/agon-origins.jpg?raw=true)

Or in a nice boxed case:

![Agon Light 2 Boxed](https://github.com/andymccall/agon-development/blob/main/assets/agon-origins-boxed.jpg?raw=true)

All these variants can be purchased from [Olimex.com](https://www.olimex.com/) or [The Pi Hut](https://thepihut.com/). They can be purchased as bundles or seperately, so you can box your Agon Light 2 later if you wish to.

Finally, there's also the Agon Console8 variant, which is a "console-ized" version of the Agon computer:

![Agon Console8](https://github.com/andymccall/agon-development/blob/main/assets/agon-console8.jpg?raw=true)

This is available from [Herber Retro Collective](https://shop.heber.co.uk/) as a bundle.

## This Document

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

More information on programming the Agon and Console8 can be found in the community documentation [here](https://agonconsole8.github.io/agon-docs/).

### Found this guide useful?

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/andymccall)

I don't write code, documents or software for profit, I do it for enjoyment and to help others. If you get anything useful from this guide, and only if you can afford it, please let me know by buying me a coffee using my Ko-fi tip page [here](https://ko-fi.com/andymccall).