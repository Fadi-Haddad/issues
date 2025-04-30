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

  # test "test the sorting function" do
  #   unordered = Enum.map(["a", "b", "c"], fn x -> %{"created_at" => x, "other" => "xxx"} end )
  #   assert sort_into_descending_order(unordered, 3) |> Enum.map(fn map -> map["created_at"] end) == ~w( c b a)
  # end
end
