defmodule Issues.GithubIssuesTest do
  use ExUnit.Case
  import Issues.GithubIssues
  import ExUnit.CaptureIO


  describe "this block tests the handle response function" do

    test "handle_response function with wrong URL" do
      captured_IO = capture_io(fn -> handle_response({:error, "URL not found"}) end)
      assert String.trim(captured_IO) == "\"Error was encountered, reason is: \\\"URL not found\\\"\""
    end

    test "handle_response function status 404" do
      captured_IO = capture_io(fn -> handle_response({:ok, %Tesla.Env{status: 404}}) end)
      assert String.trim(captured_IO) == "\"URL not found :(\""
    end
    
  end
end
