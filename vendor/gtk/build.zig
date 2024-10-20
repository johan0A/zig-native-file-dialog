const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "gtk_3_headers",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
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

    // lib.installHeadersDirectory(b.path("asm"), "asm", .{});
    // lib.installHeadersDirectory(b.path("atk"), "atk", .{});
    // lib.installHeadersDirectory(b.path("atspi"), "atspi", .{});
    // lib.installHeadersDirectory(b.path("bits"), "bits", .{});
    // lib.installHeadersDirectory(b.path("c++"), "c++", .{});
    // lib.installHeadersDirectory(b.path("dbus"), "dbus", .{});
    // lib.installHeadersDirectory(b.path("freetype"), "freetype", .{});
    // lib.installHeadersDirectory(b.path("gdk"), "gdk", .{});
    // lib.installHeadersDirectory(b.path("gdk-pixbuf"), "gdk-pixbuf", .{});
    // lib.installHeadersDirectory(b.path("gio"), "gio", .{});
    // lib.installHeadersDirectory(b.path("glib"), "glib", .{});
    // lib.installHeadersDirectory(b.path("gnu"), "gnu", .{});
    // lib.installHeadersDirectory(b.path("gobject"), "gobject", .{});
    // lib.installHeadersDirectory(b.path("gtk"), "gtk", .{});
    // lib.installHeadersDirectory(b.path("pango"), "pango", .{});
    // lib.installHeadersDirectory(b.path("sys"), "sys", .{});
    // lib.installHeadersDirectory(b.path("unix-print"), "unix-print", .{});

    b.installArtifact(lib);
}
