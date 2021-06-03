defmodule LvexamplesWeb.EventsSurfaceLive do
  use Surface.LiveView

  alias LvexamplesWeb.Live.Components.EventsSurface

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    IO.inspect("Surface live view is calling mount.")
    {:ok, assign(socket, counter: 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <EventsSurface id="surface-events" counter=0 />
    """
  end

end
