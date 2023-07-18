// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL

import std.stdio;
import std.format;
import std.file;
import std.path;
import builtin;
import parser;

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
    while (true) {
        string input;
        string prompt = format("[%s] $ ", getcwd().baseName());
        write(prompt);
        readf("%s\n", &input);
        parse_command(input);
    }
}
