const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "gtk_3_headers",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize,
    });

    lib.installHeadersDirectory(b.path("./headers/"), ".", .{});
    lib.installHeadersDirectory(b.path("./X11/"), "X11", .{});
    lib.linkLibC();
    b.installArtifact(lib);
}
