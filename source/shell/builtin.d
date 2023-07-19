import std.stdio;
import std.file;
import std.process;
import core.stdc.stdlib;

void builtin_cd(string[] args)
{
  if (args.length == 0)
  {
    writeln("dash: expected argument to \"cd\"");
    return;
  }

  string path = args[0];

  try
  {
    chdir(path);
  }
  catch (FileException e)
  {
    writeln("dash: no such file or directory: ", path);
    return;
  }

  return;
}

void colour(string[] args)
{
  string colour = args[1];

  switch (colour)
  {
  case "red":
    write("\x1b[31m");
    return;
  case "green":
    write("\x1b[32m");
    return;
  case "yellow":
    write("\x1b[33m");
    return;
  case "blue":
    write("\x1b[34m");
    return;
  case "magenta":
    write("\x1b[35m");
    return;
  case "cyan":
    write("\x1b[36m");
    return;
  case "white":
    write("\x1b[37m");
    return;
  case "reset":
    write("\x1b[0m");
    return;
  default:
    writeln("dash: invalid colour: ", colour);
    return;
  }
}

void handle_alias(string[] args){
  // TODO: Implement alias
  writeln("dash: alias not implemented yet");
  return;
}

int builtin_handler(string[] args)
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
  case "alias":
    if (args.length == 1){
      writeln("dash: expected argument to \"alias\"");
      return 0;
    }
    handle_alias(args);
    return 0;
  case "exit":
    exit(0);
  case "colour":
    if (args.length == 1){
      writeln("dash: expected argument to \"colour\"");
      return 0;
    }
    colour(args);
    return 0;
  default:
    return 1;
  }
}

