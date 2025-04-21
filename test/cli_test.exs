defmodule CliTest do
  use ExUnit.Case
  import Issues.CLI

  test "assert our function parses --help or -h flags" do
    assert parse(["--help", "other options"]) == :help
    assert parse(["-h", "other options"]) == :help
  end

  test "assert our function parses three values" do
    assert parse(["user", "project", "15"]) == ["user", "project", 15]
  end

  test "assert our function parses the passed values if count was not provided" do
    assert parse(["user", "project"]) == ["user", "project", 4]
  end
end
