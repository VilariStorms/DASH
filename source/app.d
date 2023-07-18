// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL

import std.stdio;
import std.format;
import std.file;
import std.path;
import std.socket;
import builtin;
import parser;
import utility;

void welcome_message() {
    writeln("Welcome to DASH!");
    writeln("Type 'help' to get started.");
    writeln("please insert cash or select payment card");
    writeln("You owe £79");
    writeln();
    writeln();
}

void main() {
    welcome_message();
    int prev_exit_code;
    while (true) {
        string input;
        string prompt;

        if (prev_exit_code != 0) {
            prompt = format("[%s@%s %s %f] $ ", get_user(), Socket.hostName(), getcwd().baseName(), prev_exit_code);
        } else {
            prompt = format("[%s@%s %s] $ ", get_user(), Socket.hostName(), getcwd().baseName());
        }

        write(prompt);
        readf("%s\n", &input);
        prev_exit_code = parse_command(input);
    }
}
