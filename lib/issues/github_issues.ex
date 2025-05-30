defmodule Issues.GithubIssues do
  use Tesla
  require Logger

  @github_url Application.compile_env(:issues, :github_url)

  plug(Tesla.Middleware.JSON)

  def create_link(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}")

    Tesla.get(create_link(user, project), headers: [{"User-Agent", "ElixirClient"}])
    |> handle_response()
  end

  def handle_response({:error, reason}) do
    Logger.warning("Error was encountered, reason is: #{inspect(reason)}")
  end

  def handle_response({:ok, %Tesla.Env{status: 404}}) do
    Logger.warning("URL not found :(")
  end

  def handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    Jason.decode!(body)
  end
end
