defmodule Issues.GithubIssues do
  def create_link(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def fetch(user, project) do
    Tesla.client([{Tesla.Middleware.Headers, [{"User-Agent", "ElixirClient"}]}])
    |> Tesla.get(create_link(user, project))
    |> handle_response()
  end

  def handle_response({:error, reason}) do
    IO.inspect("Error was encountered, reason is: #{inspect(reason)}")
  end

  def handle_response({:ok, %Tesla.Env{status: 404}}) do
    IO.puts("URL not found :(")
  end

  def handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    IO.inspect(body)
  end
end
