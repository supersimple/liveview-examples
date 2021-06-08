defmodule LvexamplesWeb.Live.Components.Complex.Todo do
  use LvexamplesWeb, :live_component

  def render(assigns) do
    ~L"""
    <form phx-submit="todo_list" phx-target="<%= @myself %>" class="todo_list_form">
      <h1>List for <%= @selected_date %></h1>
      <div class="clearfix todo_list_container"></div>
      <div class="add_remove_items">
        <button class="add focus:outline-none" phx-hook="AddTodo"><span>+</span></button>
        <button class="remove focus:outline-none" phx-hook="RemoveTodo"><span>-</span></button>
      </div>
    </form>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("todo_list", _params, socket) do
    {:noreply, socket}
  end
end
