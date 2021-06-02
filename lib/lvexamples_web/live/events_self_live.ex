defmodule LvexamplesWeb.EventsSelfLive do
  use LvexamplesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :counter_update, 5000)
    {:ok, assign(socket, counter: 0)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(LvexamplesWeb.LayoutView, "events_self.html", assigns)
  end

  @impl true
  def handle_info(:counter_update, socket) do
    counter = socket.assigns.counter
    Process.send_after(self(), :counter_update, 5000)
    {:noreply, assign(socket, counter: counter + 1)}
  end
end
