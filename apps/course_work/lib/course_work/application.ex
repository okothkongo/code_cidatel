defmodule CodeCitadel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CodeCitadel.Repo,
      CodeCitadel.CouserWorkWeb.Endpoint,
      # Start the PubSub system
      {Phoenix.PubSub, name: CodeCitadel.PubSub}
      # Start a worker by calling: CodeCitadel.Worker.start_link(arg)
      # {CodeCitadel.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CodeCitadel.Supervisor)
  end
end
