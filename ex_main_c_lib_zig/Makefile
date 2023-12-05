.PHONY: all clean
all: main.elf
	./main.elf

%.o: %.c
	zig cc -o $@ -c $<

libsub.a: sub.zig
	zig build-lib $<

main.elf: main.o libsub.a 
	zig cc -o $@ $^

clean:
	rm -f *.a *~ *.o *.elf
	rm -rf zig-cache

