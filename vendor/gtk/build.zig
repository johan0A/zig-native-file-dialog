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

    const headers_root = "./headers/";
    const header_folders = [_][]const u8{
        "asm",
        "atk",
        "atspi",
        "bits",
        "c++",
        "dbus",
        "freetype",
        "gdk",
        "gdk-pixbuf",
        "gio",
        "glib",
        "gnu",
        "gobject",
        "gtk",
        "pango",
        "sys",
        "unix-print",
    };

    inline for (header_folders) |folder| {
        lib.installHeadersDirectory(b.path(headers_root ++ folder), folder, .{});
    }
    lib.installHeadersDirectory(b.path(headers_root), ".", .{});
    lib.installHeadersDirectory(b.path(headers_root ++ "pthread"), ".", .{});
    lib.installHeadersDirectory(b.path(headers_root ++ "features-time64"), "features-time64", .{});

    if (b.lazyDependency("x11_headers", .{
        .target = target,
        .optimize = optimize,
    })) |dep| {
        lib.linkLibrary(dep.artifact("x11-headers"));
        lib.installLibraryHeaders(dep.artifact("x11-headers"));
    }

    lib.linkLibC();

    b.installArtifact(lib);
}
