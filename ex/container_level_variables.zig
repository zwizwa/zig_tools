fn foo() u8 {
    // Note that there are two concepts here:
    //
    // 1. The identifier S holds the type, and that is const, i.e. the
    //    type doesn't change.
    //
    // 2. The type has a container level variable x, which is not
    //    const.
    //
    // There is no "instance of the struct" here.  It is purely a
    // compile-time entity.

    const S = struct {
        var x: u8 = 1;
    };
    S.x += 1;
    return S.x;
}
pub fn main() u8 {
    return foo();
}
