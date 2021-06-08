defmodule LvexamplesWeb.Live.Components.EventsUpDown do
  use LvexamplesWeb, :live_component

  @impl true
  def mount(socket) do
    IO.inspect("Component is calling mount.")
    {:ok, socket}
  end

  @impl true
  def update(%{id: _id, increment: inc}, socket) do
    {:ok, assign(socket, counter: socket.assigns.counter + inc)}
  end

  def update(assigns, socket) do
    IO.inspect(assigns, label: "assigns given to update")
    IO.inspect("Component is calling update.")
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <div class="flex-1">
      <h1><%= @counter %></h1>
      <button phx-click="counter_update" phx-value-target="<%= @target %>" class="rounded bg-red-600 px-8">+</button>
      </div>
    """
  end
end
