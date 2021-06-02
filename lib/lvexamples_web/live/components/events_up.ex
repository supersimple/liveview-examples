defmodule LvexamplesWeb.Live.Components.EventsUp do
  use LvexamplesWeb, :live_component

  @impl true
  def mount(socket) do
    IO.inspect("Stateless component is calling mount.")
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    IO.inspect("Stateless component is calling update.")
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <h1><%= @counter %></h1>
      <button phx-click="counter_update" class="rounded bg-yellow-600 px-8">+</button>
    """
  end
end
