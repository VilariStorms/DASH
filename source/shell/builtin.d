import std.stdio;
import std.file;
import std.process;
import core.stdc.stdlib;

void builtin_cd(string[] args) {
    if (args.length == 0) {
        writeln("dash: expected argument to \"cd\"");
        return;
    }

    string path = args[0];

    try {
        chdir(path);
    } catch (FileException e) {
        writeln("dash: no such file or directory: ", path);
        return;
    }

    return; 
}

int builtin_handler(string[] args) {
    if (args.length == 0) {
        return 1;
    }

    string cmd = args[0];

    switch (cmd) {
        case "cd":
            builtin_cd(args[1 .. $]);
            return 0;
        case "help":
            writeln("DASH - D Programming Language Shell");
            writeln("Written by: XDRC");
            return 0;
        case "exit":
            exit(0);
        default:
            return 1;
        }
}