// Example: DSL syntax using tagged unions + eval()

const std = @import("std");
const expect = std.testing.expect;

const stdout = std.io.getStdOut().writer();
// try stdout.print("Hello, {s}!\n", .{"world"});

const StxTag = enum {
    op2,
    lit,
};
const Op = enum { add };
const Op2 = struct { op: Op, a: *const Stx, b: *const Stx };
const Stx = union(StxTag) {
    op2: Op2,
    lit: u32,
};

fn eval(stx: *const Stx) u32 {
    switch (stx.*) {
        StxTag.op2 => |op2| {
            const a = eval(op2.a);
            const b = eval(op2.b);
            switch (op2.op) {
                Op.add => {
                    return a + b;
                },
            }
        },
        StxTag.lit => |lit| {
            return lit;
        },
    }
}

export fn add(a_val: u32, b_val: u32) u32 {
    const a = Stx{ .lit = a_val };
    const b = Stx{ .lit = b_val };
    const op_add = Stx{ .op2 = Op2{
        .op = Op.add,
        .a = &a,
        .b = &b,
    } };
    return eval(&op_add);
    // return @call(.{ .modifier = .always_inline }, eval, .{&op_add});
}

pub fn main() !void {
    const rv = add(1, 2);
    try stdout.print("rv={}\n", .{rv});
}
