defmodule CLI do
  @default_count 4
  @docmodule """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """
  @doc """
  This module serves as the entry point for the escript-based CLI tool.
  escript lets you build standalone executabls(like git, curl, mix...)
  When compiled with Mix and run from the command line, escript calls `run/1`,
  passing in the command-line arguments as a list. This function handles argument parsing
  and dispatches to the appropriate logic for fetching and displaying GitHub issues.
  You can create tools and scripts that people can run without needing to install Elixir or Mix separately.
  you get full access to the Elixir ecosystem (HTTP clients, JSON parsing, etc.)
  """
  def run(argv) do
    parse(argv)
  end
  @doc """
  """
  def parse(argv) do
     parse = OptionParser.parse(argv, switches: [help: :boolean],
                                aliases: [h: :help])
     case parse do
      {[help: :true], _, _} -> :help
      {_, [user, project, count], _} -> [user, project, count]
      {_, [user, project], _} -> [user, project, @default_count]
      _ -> :help
     end
  end

end
