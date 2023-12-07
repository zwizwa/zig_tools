// Zig goes to great length to not implement macros or
// syntax-mangling.  Can we build DSLs anyway?
//
// The goal is to have something that compiles to machine code
// expressing a function,
//
// What I've noticed in ex_dsl is that inline doesn't always work.
// For types however, it has to always work.  This gives a hint that
// syntax variantes should be individual types.
//
// See here:
// https://ikrima.dev/dev-notes/zig/zig-metaprogramming/
//
// Encoding things at type level and then compiling that down to a
// type is quite straightforward.  But I don't think it is really that
// useful, because injecting run-time values in the way I assumed was
// possible (holes, i.e. functions) doesn't seem to work.
//
// What's left here doesn't make a whole lot of sense without the
// ability to generate functions.

const std = @import("std");
const expect = std.testing.expect;

const stdout = std.io.getStdOut().writer();
// try stdout.print("Hello, {s}!\n", .{"world"});

const Add = struct {};

// FIXME: Integers represented as lengh of array, while there is a
// comptime_int type.
fn Lit(comptime n: u32) type {
    return [n]void;
}
fn Op2(comptime op: type, comptime a: type, comptime b: type) type {
    return struct { op, a, b };
}

fn compile(comptime stx: type) u32 {
    // See definition of Type in zig/lib/std/builtin.zig
    const info = @typeInfo(stx);
    return switch (info) {
        .Array => info.Array.len,
        .Struct => {
            const f = info.Struct.fields;
            const op = f[0].type;
            const a = compile(f[1].type);
            const b = compile(f[2].type);
            return switch (op) {
                Add => a + b,
                else => {
                    @compileError("Bad Type");
                },
            };
        },
        else => {
            @compileError("Bad Type");
        },
    };
}
pub fn main() !void {
    const rv = compile(Op2(Add, Lit(1), Op2(Add, Lit(2), Lit(3))));
    try stdout.print("rv = {}\n", .{rv});
}
