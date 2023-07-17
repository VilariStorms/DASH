// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL


import std.stdio;
import std.string;
import std.conv;
import std.file;


void init_shell()
{
    writeln("Welcome to DASH!");
    writeln("Type 'help' to get started.");
    writeln("please insert cash or select payment card");
    writeln("You oww £79");
    writeln();
    writeln();
}

void main() {
    init_shell();
    string input;
    while (true) {
        write("$ ");
        readf("%s\n", &input);
        if (input == "help") {
            writeln("help - print this message");
            writeln("exit - exit the shell");
        } else if (input == "exit") {
            break;
        } else {
            writeln("Unknown command: ", input);
        }
    }
}
