const std = @import("std");
const builtin = @import("builtin");
const Builder = std.build.Builder;

const Util = struct {
    file: []const u8,

    pub fn name(self: @This()) []const u8 {
        std.debug.assert(std.mem.endsWith(u8, self.file, ".zig"));
        return self.file[0 .. self.file.len - 4];
    }
};

const utils = [_]Util{
    .{ .file = "prompt.zig" },
};

pub fn build(b: *Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    for (utils) |util| {
        const exe = b.addExecutable(util.name(), util.file);
        {
            exe.setTarget(target);
            exe.setBuildMode(mode);
            exe.install();
        }

        const run_cmd = exe.run();
        {
            run_cmd.step.dependOn(b.getInstallStep());
            if (b.args) |args| {
                run_cmd.addArgs(args);
            }
        }

        const run_step = b.step(util.name(), b.fmt("Run {s}", .{util.name()}));
        run_step.dependOn(&run_cmd.step);
    }
}
