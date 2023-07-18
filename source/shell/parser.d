import std.stdio;
import std.process;
import std.array;
import builtin;

void parse_command(string input) {
    string[] args = input.split();
    // check if builtin    
    if (builtin_handler(args) == 0){return;}

    // check if executable
    try {
        auto pid = spawnProcess(args);
        pid.wait();
    } catch (ProcessException e) {
        writefln("dash: command: %s, not found!", args);
        return;
    }  
    return;
}
