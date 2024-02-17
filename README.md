# Building an OS

The project is a low-level operating system.
Created with x86_64 assembly using:
- Makefile # used to manage project commands
- nasm # assembler
- qemu # used to create the virtual machine

To generate the project build, run command below in the project root directory:
	make

The project image will be generated in the "bulid" directory

To start the system, simply run the command below: 

	qemu-system-i386 -fda build/main_floppy.img
