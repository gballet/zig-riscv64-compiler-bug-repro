const std = @import("std");
const builtin = @import("builtin");
const Builder = std.Build;

pub fn build(b: *Builder) !void {
    const optimize = .ReleaseFast;

    const target_query = try std.Build.parseTargetQuery(.{ .arch_os_abi = "riscv64-freestanding-none", .cpu_features = "generic_rv64" });
    const target = b.resolveTargetQuery(target_query);

    // target has to be riscv5 runtime provable/verifiable on zkVMs
    var exe = b.addExecutable(.{
        .name = "repro",
        .root_source_file = b.path("src/main.zig"),
        .optimize = optimize,
        .target = target,
    });
    // addimport to root module is even required afer declaring it in mod
    exe.addAssemblyFile(b.path("src/start.s"));
    exe.pie = true;
    exe.setLinkerScript(b.path("src/repro.ld"));
    b.installArtifact(exe);
}
