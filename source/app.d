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

int firstime(){

  return 0;
}

int readconfig(){
  return 0;
}

int aliases(string[] args){
  
  return 1;
}


int startup(){
  // check if ~/.dash_shell exists
    if(firstime != 0){
      writeln("Cant initalise shell's first time setup");
      writeln("Something is very wrong..or more likely you need to run with sudo the first time!");
      return 1;
    }
    if(readconfig != 0){
      writeln("Error reading config! Using basic settings for now :3");
      writeln("You should probably fix your config! (vim/vi/nano ~/.dash_shell)");
      writeln("You can also check the github for example configs to use!");
      return 2;
    }

  return 0;

}

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
    auto default_aliases = ["l": "ls -la", "ll": "ls -l", "q": "exit", "c": "clear"];
    switch (startup)   {
      case 0:
        writeln("Startup successful!");
        break;
      case 1:
        writeln("Error in startup, something is very wrong!");
        return;
      case 2:
        writeln("Using default config!");
        break;
      default:
        writeln("Error in startup, something is very wrong!");
        return;
    }
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
        // check for aliases
        if ((input in default_aliases) != null) {
          input = default_aliases[input];
        }
        prev_exit_code = parse_command(input);
    }
}
