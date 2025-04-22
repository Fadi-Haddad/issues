defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handles command-line parsing and dispatching to
  functions that fetch and display the last _n_ issues
  from a GitHub project.

  This module serves as the entry point for an escript-based CLI tool.

  Escript lets you build standalone executables (like `git`, `curl`, `mix`).
  When compiled with Mix and run from the command line, `escript` calls `run/1`,
  passing in the command-line arguments as a list.

  With `escript`, you can create tools and scripts that people can run without
  needing to install Elixir or Mix separately, while still having full access
  to the Elixir ecosystem (HTTP clients, JSON parsing, etc.), only erlang is needed.
  """

  @doc """
  Entry point for the CLI. If you use Escript to build the cli (Escript Bundles your Elixir code into a single self-contained binary),
  Then run function gets called automatically whenever you run your code.

  Calls the parse_args function which parses the command-line arguments and triggers appropriate behavior.
  """
  def run(argv) do
    argv
    |> parse_args()
    |> process()
  end

  @doc """
  Parses command-line arguments.

  Recognized formats:
    - `--help` or `-h`: Displays help.
    - `<user> <project> <count>`: Gets the last `count` issues from a GitHub repo.
    - `<user> <project>`: Defaults to getting the last #{@default_count} issues.

  Returns:
    - `:help` atom for help flags or invalid formats.
    - A list `[user, project, count]` when valid arguments are provided.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help]) # returns a tuple of three lists {[args], [options], {ignored}}
    case parse do
      {[help: true], _, _} -> :help
      {_, [user, project, count], _} -> [user, project, String.to_integer(count)]
      {_, [user, project], _} -> [user, project, @default_count]
      _ -> :help
    end
  end
  def process(:help) do
    IO.inspect "usage: issues <user> <project> [ count | 4 ]"
    System.halt(0)
  end
  def process([_user, _project, _count]) do
    
  end

end
