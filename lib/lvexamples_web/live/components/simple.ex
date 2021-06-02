defmodule LvexamplesWeb.Live.Components.Simple do
  use LvexamplesWeb, :live_component

  def render(assigns) do
    ~L"""
      <h1><%= @counter %></h1>
    """
  end
end
