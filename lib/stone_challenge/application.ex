defmodule StoneChallenge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: StoneChallenge.Worker.start_link(arg)
      # {StoneChallenge.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: StoneChallenge.Server, options: [port: 4001]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StoneChallenge.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
