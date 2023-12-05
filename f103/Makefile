# https://github.com/markfirmware/zig-vector-table/blob/239aefc4032b5ffaf689b39ac94d7aabd5938e57/build.zig#L77-L82

all:
	zig build-exe -target thumb-freestanding -mcpu cortex_m3 --name main.elf --script memory.ld main.zig
	arm-none-eabi-objdump -d main.elf

# panic is infinite loop around "bkpt 0"
