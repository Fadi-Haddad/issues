defmodule Issues.GithubIssues do

  @user_agent [{"User-Agent", "ElixirClient"}]

  def create_link(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def fetch(user, project) do
    create_link(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect "error was encountered, reason is #{reason}"
  end
  def handle_response({:ok, %HTTPoison.Response{status_code: 404}}) do
    IO.puts "URL not found :("
  end
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    IO.puts body
  end

end
