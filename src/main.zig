const std = @import("std");

pub fn print_str(str: []const u8) void {
    var addr: [*]volatile u8 = @ptrFromInt(0x1000_0000);
    for (str) |c| {
        addr[0] = c;
    }
}

export fn main() noreturn {
    var buf: [245]u8 = undefined;
    print_str(std.fmt.bufPrint(buf[0..], "{}", .{392}) catch @panic("error allocating buf"));
    unreachable;
}
