.section .text
.global _start
.module mips16
_start:
	break
	addiu $s0, $sp, 0x100
	jal main

.section .data
test: .asciz "test"
