all:
	cd test ; zig build test run
	cd c ; zig cc test.c ; ./a.out
