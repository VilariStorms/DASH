// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL

import std.stdio;
import std.format;
import std.file;
import std.array;
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

void handle_alias(string[] args, string[string] dash_aliases){
  if (args.length != 3)
  {
    writeln("dash: alias: wrong number of arguments");
    writeln("alias: usage: alias [name] [command]");
    return;
  }
  string name = args[1];
  string command = args[2];
  // check if alias already exists
  if ((name in dash_aliases) != null)
  {
    writeln("dash: alias already exists: ", name);
    return; 
  }
  dash_aliases[name] = command;
  return;
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
    auto dash_aliases = ["l": "ls -la", "ll": "ls -l", "q": "exit", "c": "clear"];
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

        string[] input_arr = input.split;
        if (input_arr.length == 0) {
            continue;
        }

        // check if we are setting an alias
        if (input_arr[0] == "alias") {
          handle_alias(input_arr, dash_aliases);
          continue;
        }
        // Loop through input_arr and replace aliases
        for (int i = 0; i < input_arr.length; i++) {
          if ((input_arr[i] in dash_aliases) != null) {
            // split the alias into an array in case it has multiple arguments
            string[] alias_arr = dash_aliases[input_arr[i]].split;
            // replace the alias with the command and add the arguments if any - insering at the index of the alias
            input_arr = input_arr[0 .. i] ~ alias_arr ~ input_arr[i + 1 .. $];
          }
        }
        prev_exit_code = parse_command(input_arr);
    }
}
