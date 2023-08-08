// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL

import std.stdio;
import std.format;
import std.file;
import std.array;
import std.path;
import std.socket;
//import core.sys.posix.termios;
// import core.sys.posix.stdio;
//import core.sys.posix.unistd;
import dyaml;
import builtin;
import parser;
import utility;


const string defaultconfig = "
# DASH config file
# This is a yaml file, you can find more info on yaml here: https://yaml.org/
# You can also find example configs on the github page:
#
aliases:
  l: ls -la
  ll: ls -l
  q: exit
  c: clear

";

void firstime()
{
  // check if ~/.dash_shell exists

  const string configpath = "/home/" ~ get_user() ~ "/.dash_shell";
  if (!exists(configpath))
  {
    File file = File(configpath, "w");
    if (file.isOpen)
    {
      file.write(defaultconfig);
      file.close();
    }
    else
    {
      writeln("Error creating the config.");
    }
  }
  return;
}

int readconfig()
{
  return 0;
}

int startup()
{
  // check if ~/.dash_shell exists
  firstime();
  if (readconfig != 0)
  {
    writeln("Error reading config! Using basic settings for now :3");
    writeln("You should probably fix your config! (vim/vi/nano ~/.dash_shell)");
    writeln("You can also check the github for example configs to use!");
    return 1;
  }

  return 0;

}

void handle_alias(string[] args, string[string] dash_aliases)
{
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

void welcome_message()
{
  writeln("Welcome to DASH!");
  writeln("Type 'help' to get started.");
  writeln("please insert cash or select payment card");
  writeln("You owe £79");
  writeln();
  writeln();
}

void main()
{
  welcome_message();
  int prev_exit_code;
  auto dash_aliases = ["l": "ls -la", "ll": "ls -l", "q": "exit", "c": "clear"];
  switch (startup)
  {
  case 0:
    writeln("Startup successful!");
    break;
  case 1:
    writeln("Using default config!");
    break;
  default:
    writeln("Error in startup, something is very wrong!");
    return;
  }
  while (true)
  {
    string input;
    string prompt;
    
    if (prev_exit_code != 0)
    {
      prompt = format("[%s@%s %s %f] $ ", get_user(), Socket.hostName(), getcwd().baseName(), prev_exit_code);
    }
    else
    {
      prompt = format("[%s@%s %s] $ ", get_user(), Socket.hostName(), getcwd().baseName());
    }

    write(prompt);
     readf("%s\n", &input);
    // split input into an array
    string[] input_arr = input.split;
    if (input_arr.length == 0)
    {
      continue;
    }
    prev_exit_code = parse_command(input_arr);
  }
}
