// DASH - D Programming Language Shell
// Written by: XDRC
// License: WTWYEDTL

import std.stdio;
import std.format;
import std.path;
import std.file;
import std.process;
import std.string;
import std.array;
import std.conv;
import core.stdc.stdlib;

void init_shell()
{
  writeln("Welcome to DASH!");
  writeln("Type 'help' to get started.");
  writeln("please insert cash or select payment card");
  writeln("You owe £79");
  writeln();
  writeln();
}

int builtin_cd(string[] args)
{
  if (args.length == 0)
  {
    writeln("dash: expected argument to \"cd\"");
    return 1;
  }
  string path = args[0];
  try
  {
    chdir(path);
  }
  catch (FileException e)
  {
    writeln("dash: no such file or directory: ", path);
    return 1; 
  }
  return 0;

  //if (chdir(path) != 0) {
  //   writeln("dash: no such file or directory: ", path);
  //}
}

int builtin(string[] args)
{
  if (args.length == 0)
  {
    return 1;
  }
  string cmd = args[0];
  switch (cmd)
  {
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

void parse_command(string input)
{
  string[] args = input.split();
  // check if builtin    
  if (builtin(args) == 0)
  {
    return;
  }
  // fork and exec
  if (execv(args[0], args) == -1)
  {
    writeln("dash: command not found: ", args[0]);
  }
  return;
}

void main()
{
  init_shell();
  while (true)
  {
    string input;
    string prompt = format("[%s] $ ", getcwd().baseName());
    write(prompt);
    readf("%s\n", &input);
    parse_command(input);

  }
}
