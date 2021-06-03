defmodule LvexamplesWeb.Live.Components.EventsSurface do
  use Surface.LiveComponent

  prop counter, :integer, required: true

  @impl true
  def mount(socket) do
    IO.inspect("Surface component is calling mount.")
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    IO.inspect("Surface component is calling update.")
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class="text-center mt-24 text-8xl">
        <h1>{{ @counter }}</h1>
        <button :on-click="counter_update" class="rounded bg-yellow-600 px-8">+</button>
      </div>
    """
  end

  @impl true
  def handle_event("counter_update", _params, socket) do
    IO.puts("Surface component is calling handle_event.")
    counter = socket.assigns.counter
    {:noreply, assign(socket, counter: counter + 1)}
  end
end
