defmodule Issues.CliTest do
  use ExUnit.Case
  import Issues.CLI

  test "assert our function parses --help or -h flags" do
    assert parse_args(["--help", "other options"]) == :help
    assert parse_args(["-h", "other options"]) == :help
  end

  test "assert our function parses three values" do
    assert parse_args(["user", "project", "15"]) == ["user", "project", 15]
  end

  test "assert our function parses the passed values if count was not provided" do
    assert parse_args(["user", "project"]) == ["user", "project", 4]
  end
end
