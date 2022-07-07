const std = @import("std");
const builtin = @import("builtin");
const packages = @import("packages.zig").packages;

pub fn main() anyerror!void {
    std.log.info("Creating a build.ninja file", .{});

    const rule =
        \\rule copy
        \\  command = cp $in $out
        \\
    ;

    var home = std.os.getenv("HOME");

    const ninja_file = try std.fs.cwd().createFile("build.ninja", .{});
    defer ninja_file.close();
    try ninja_file.writer().print("home = {s}\n{s}", .{ home, rule });

    const build_template = "build $home/{s}: copy {s}\n";

    // Deleting the directory first to only keep the scripts that we need.
    try std.fs.cwd().deleteTree("scripts");
    try std.fs.cwd().makeDir("scripts");

    const scripts_dir = try std.fs.cwd().openDir("scripts", .{});

    const packages_script = try scripts_dir.createFile("install_packages.sh", .{});
    defer packages_script.close();
    try packages_script.writer().print("#!/bin/sh -e\n", .{});

    for (packages) |pkg| {
        if (pkg.target != null and pkg.file != null)
            try ninja_file.writer().print(build_template, .{ pkg.target, pkg.file });

        if ((pkg.target != null and pkg.file == null) or (pkg.target == null and pkg.file != null))
            std.log.warn("{s} is not correctly described", .{pkg.name});

        if (pkg.script != null) {
            const script_file = try scripts_dir.createFile(pkg.title, .{});
            defer script_file.close();
            try script_file.writer().print("#!/bin/sh -e\n{s}", .{pkg.script});
        }
        if (pkg.name_macos != null and builtin.os.tag == .macos) {
            try packages_script.writer().print("doas port install {s}\n", .{pkg.name_macos});
        } else if (pkg.name != null) {
            try packages_script.writer().print("doas xbps-install {s}\n", .{pkg.name});
        }
    }

    std.log.info("You may run samurai :^)", .{});
}
