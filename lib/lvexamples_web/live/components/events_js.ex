defmodule LvexamplesWeb.Live.Components.EventsJS do
  use LvexamplesWeb, :live_component

  @impl true
  def preload(list_of_assigns) do
    IO.puts("Stateful component is calling preload.")
    list_of_assigns
  end

  @impl true
  def mount(socket) do
    IO.puts("Stateful component is calling mount.")
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    IO.puts("Stateful component is calling update.")
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <button phx-target="<%= @myself %>" phx-hook="CounterUpdate" class="rounded bg-yellow-600 px-8">+</button>
      <ul></ul>
    """
  end
end
