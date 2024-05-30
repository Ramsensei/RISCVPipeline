# Risc-V Unicycle Proccessor
This is a project that implements a microarquitechture designed to run for Risc-V arquitechture.
There is only 8 instructions implemented:

- ld
- sd
- add
- sub
- and
- or
- beq
- addi
---
## How to execute it
For run it in linux (iverilog and gtkwave need to be installed):
`make test filename.sv`

For run it in windows (iverilog and gtkwave need to be installed and in the path):
`make test_win filename.sv`

For run it using VCS and gtkwave (linux only):
`make test_vcs filename.sv`

For run it using VCS gui (linux only):
`make test_gui filename.sv`

Where `filename.sv` is the module you want to run.

---
## Programing the proccessor
If you want to change the program you must compile your program in hex and put it in the "memory.dat" file.

Is recommended to use [this](https://riscvasm.lucasteske.dev/) assembler.

The program that is rigth now in memory.dat is the following:

```
addi x1, x0, 2

add x2, x1, x1

sub x3, x2, x1

and x4, x1, x3

or x5, x1, x2

beq x3, x1, jump

sub x2, x2, x1 /* Should not be executed */

jump:

sd x2, 0(x0)

ld x6, 0(x0)
```
 
