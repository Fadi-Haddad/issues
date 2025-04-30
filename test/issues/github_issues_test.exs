defmodule Issues.GithubIssuesTest do
  use ExUnit.Case
  import Issues.GithubIssues
  # import ExUnit.CaptureIO
  import ExUnit.CaptureLog

  describe "this block tests the handle response function" do
    test "handle_response function with wrong URL" do
      captured_IO = capture_log(fn -> handle_response({:error, "URL not found"}) end)
      assert captured_IO =~ "Error was encountered"
      assert captured_IO =~ "URL not found"
    end

    test "handle_response function status 404" do
      captured_IO = capture_log(fn -> handle_response({:ok, %Tesla.Env{status: 404}}) end)
      assert captured_IO =~ "URL not found :("
    end
  end
end
