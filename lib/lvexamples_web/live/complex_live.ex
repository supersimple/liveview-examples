defmodule LvexamplesWeb.ComplexLive do
  use LvexamplesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{selected_date: Date.utc_today(), calendar_open: false})}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(LvexamplesWeb.LayoutView, "complex.html", assigns)
  end

  @impl true
  def handle_info({:selected_date, date}, socket) do
    socket = assign(socket, selected_date: date, calendar_open: true)
    {:noreply, socket}
  end
end
