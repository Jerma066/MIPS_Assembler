.text
main:
li	$t0,	5
li	$v0,	5

# a0 = v0 + t0
add 	$a0,	$v0,	$t0

# a1 = v0*t0
mul 	$a1,	$t0,	$v0

# a2 = v0  - t0
sub 	$a2,	$v0,	$t0

#exit (terminate execution)
li	$v0,	4
syscall	


.data