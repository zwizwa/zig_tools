/* Test1: main() function in C, calling into Zig code, using zig cc
   and zig build-lib in a Makefile */
#include <stdio.h>
#include <stdint.h>
uint32_t test_zig(uint32_t);
int main(int argc, char **argv) {
    fprintf(stderr, "%d\n", test_zig(1));
    return 0;
}
