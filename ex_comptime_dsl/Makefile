.PHONY: all
all: comptime_dsl
	./comptime_dsl

comptime_dsl: comptime_dsl.zig
	zig version
	zig build-exe -O ReleaseSmall comptime_dsl.zig 

