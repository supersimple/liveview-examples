defmodule Lvexamples.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LvexamplesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lvexamples.PubSub},
      # Start the Endpoint (http/https)
      LvexamplesWeb.Endpoint
      # Start a worker by calling: Lvexamples.Worker.start_link(arg)
      # {Lvexamples.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lvexamples.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LvexamplesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
