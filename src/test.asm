    la a0, AL          # cycle = 9 / 19, addr = 0x00000000
    lw a0, 0(a0)       # cycle = 29, a0 = -2 / 0xfffffffe, addr = 0x00000008
    blt a0, zero, L1   # cycle = 46, addr = 0x0000000c
L1  addi a7, a0, 13    # cycle = 56, a7 = 11 / 0x0000000b, addr = 0x00000010
    bge zero, a7, L1   # cycle = 66, addr = 0x00000014
	la a0, AL          # cycle = 76 / 86, addr = 0x00000018
    lb a1, 1(a0)       # cycle = 96, a1 = -1 / 0xffffffff, addr = 0x00000020
    xori a2, a1, 0x7FF # cycle = 113, a2 = -2048 / 0xfffff800, addr = 0x00000024
	lw a0, 0(a0)       # cycle = 123, a0 = -2 / 0xfffffffe, addr = 0x00000028
    add a3, a2, a0     # cycle = 140, a3 = -2050 / 0xfffff7fe, addr = 0x0000002c
    add a4, a2, a0     # cycle = 150, a4 = -2050 / 0xfffff7fe, addr = 0x00000030
    addi a5, a7, -1    # cycle = 160, a5 = 10 / 0x0000000a, addr = 0x00000034
    jal zero, L2       # cycle = 170, addr = 0x00000038

L3  halt
    halt
L2  jal zero, L3       # cycle = 181, addr = 0x00000044
L4  halt
L5  halt
AL   .FILL -2
BL   .FILL -9