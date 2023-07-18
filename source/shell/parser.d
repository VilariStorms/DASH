import std.stdio;
import std.process;
import std.array;
import std.file;
import builtin;

int parse_command(string input) {
    if (input == "") {
        return 0;
    } else {
        string[] cmds = input.split("|");
        string[][] args;
        
        foreach (cmd; cmds) { args ~= cmd.split(); }

        int exit_code;
        File prev_out = File.tmpfile();
        File in_buf = File.tmpfile();
        string buf;

        // check if builtin
        foreach (i; 0..args.length) {
            if (builtin_handler(args[i]) == 0) {
                return 0;
            } else {
                // check if executable
                try {
                    if (args.length == 1) {
                        auto pid = spawnProcess(args[i]);
                        exit_code = pid.wait();
                    } else {
                        if (i == 0) {
                            auto pid = spawnProcess(args[i], stdin, prev_out, stderr, null, Config.retainStdout);
                            pid.wait();
                            buf = prev_out.readln();
                            writefln("%s", buf);
                        } else if (i != 0 && i != args.length) {
                            auto pid = spawnProcess(args[i], in_buf, prev_out, stderr, null, Config.retainStdout | Config.retainStdin);
                            exit_code = pid.wait();
                        } else {
                            auto pid = spawnProcess(args[i], in_buf, stdout, stderr, null, Config.retainStdin);
                            exit_code = pid.wait();
                        }
                    }
                } catch (ProcessException e) {
                    writefln("dash: command: %s, not found!", args[i][0]);
                    return 1;
                }  
            }
        }

        return exit_code;
    }
}
