import std.stdio;
import std.process;
import std.array;
import builtin;

int parse_command(string[] args)
{
  string[] left;
  string[] right;
  bool is_pipe = false;
  if (args[0] == "")
  {
    return 0;
  }

  int exit_code;
  // check if builtin    
  if (builtin_handler(args) == 0)
  {
    return 0;
  }
  // check if executable

  // Check for pipes
  if (args.length > 1)
  {
    for (int i = 0; i < args.length; i++)
    {
      if (args[i] == "|")
      {
        left = args[0 .. i];
        right = args[i + 1 .. args.length];
        is_pipe = true;
        break;
        //               return exit_code;
      }
    }
  }
  if (is_pipe)
  {
    try
    {
      auto pipe1 = pipeProcess(left, Redirect.stdout);
      auto pipe2 = pipeProcess(right, Redirect.stdin);
      scope(exit) wait(pipe2.pid);
      foreach (line; pipe1.stdout.byLine())
      {
        pipe2.stdin.write(line ~ "\n"); // add back the newline
      }
      pipe2.stdin.close();
      exit_code = pipe2.pid.wait();
      return exit_code;
    }
    catch (ProcessException e)
    {
      writefln("dash: command: %s, not found!", args);
      return 1;
    }
  }
  // try to execute
  try
  {
    auto pid = spawnProcess(args);
    exit_code = pid.wait();
  }
  catch (ProcessException e)
  {
    writefln("dash: command: %s, not found!", args);
    return 1;
  }
  return exit_code;
}
