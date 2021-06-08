defmodule LvexamplesWeb.ComplexLive do
  use LvexamplesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(LvexamplesWeb.LayoutView, "complex.html", assigns)
  end
end
