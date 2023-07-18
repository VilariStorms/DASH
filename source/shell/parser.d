import std.stdio;
import std.process;
import std.array;
import std.file;
import builtin;

int parse_command(string input) {
    if (input == "") return 0;

    string[] cmds = input.split("|");
    string[][] args;
        
    foreach (cmd; cmds) args ~= cmd.split();

    int exit_code;
    string[] buf;

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
                        auto pipes = pipeProcess(args[i], Redirect.stdout);
                        pipes.pid.wait();
                        foreach (chr; pipes.stdout.byLine) buf ~= get(chr);
                        pipes.stdout.close();
                    } else if (i != 0 && i != args.length - 1) {
                        auto pipes = pipeProcess(args[i], Redirect.stdin | Redirect.stdout);
                        foreach (line; buf) pipes.stdin.writeln(line);
                        pipes.stdin.flush();
                        pipes.stdin.close();
                        pipes.pid.wait();
                        buf = [];
                        foreach (line; pipes.stdout.byLine) buf ~= get(chr);
                        pipes.stdout.close();
                    } else {
                        auto pipes = pipeProcess(args[i], Redirect.stdin);
                        foreach (line; buf) pipes.stdin.writeln(line);
                        pipes.stdin.flush();
                        pipes.stdin.close();
                        pipes.pid.wait();
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
