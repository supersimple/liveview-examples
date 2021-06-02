defmodule LvexamplesWeb.Live.Components.EventsSelf do
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
      <h1><%= @counter %></h1>
      <button phx-target="<%= @myself %>" phx-click="counter_update" class="rounded bg-yellow-600 px-8">+</button>
    """
  end

  @impl true
  def handle_event("counter_update", _params, socket) do
    counter = socket.assigns.counter
    {:noreply, assign(socket, counter: counter + 1)}
  end

end
