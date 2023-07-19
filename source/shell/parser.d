import std.stdio;
import std.process;
import std.array;
import builtin;

int parse_command(string input) {
    if (input == "") { return 0; }
    
    string[] args = input.split();
    int exit_code;
    // check if builtin    
    if (builtin_handler(args) == 0) { return 0; }
    // check if executable
    try {
        auto pid = spawnProcess(args);
        exit_code = pid.wait();
    } catch (ProcessException e) {
        writefln("dash: command: %s, not found!", args);
        return 1;
    }  
    return exit_code;
}
