import std.stdio;

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
    while (true) {
        write("$ ");
        string input = readln();
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
