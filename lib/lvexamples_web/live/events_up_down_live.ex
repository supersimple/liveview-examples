defmodule LvexamplesWeb.EventsUpDownLive do
  use LvexamplesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(LvexamplesWeb.LayoutView, "events_up_down.html", assigns)
  end

  @impl true
  def handle_event("counter_update", %{"target" => tgt}, socket) do
    send_update(LvexamplesWeb.Live.Components.EventsUpDown, id: tgt, increment: 1)
    {:noreply, socket}
  end
end
