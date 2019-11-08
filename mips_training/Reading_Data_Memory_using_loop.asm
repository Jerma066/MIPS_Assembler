.text
	main:
li	$t0,	0x10010000

Loop:
# if t0 and 0x10010020 equal execute "EndLoop"
beq	$t0,	0x10010020,	EndLoop

lb	$a0,	($t0)

li	$v0,	11
syscall

addi,	$t0,	$t0,	0x01
# jump to "Loop"
j	Loop

EndLoop:
li	$v0,	10
syscall 




.data
nus_str:	.asciiz	"Nusrik loves quantum mechanics" 