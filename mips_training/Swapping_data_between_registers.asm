.text
	main:
li	$t0,	0x100
li	$t1,	0x200

# swapping data between registers
# t2 = t0
move	$t2,	$t0	
move	$t0,	$t1
move	$t1,	$t2

#exit (terminate execution)
li	$v0,	10
syscall	