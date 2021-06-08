defmodule LvexamplesWeb.Live.Components.Complex.Todo do
  use LvexamplesWeb, :live_component

  def render(assigns) do
    ~L"""
    <form phx-submit="match_prizes" phx-target="<%= @myself %>" @submit="tab = ''" class="prizes_list_form">
      <input type="hidden" name="match_id" value="<%= @match.id %>" />
      <input type="hidden" name="league" value="<%= @match.league %>" />
      <div class="clearfix prizes_list_container">
        <%= for prize <- @prizes do %>
          <label><input type="number" name="prizes[]" value="<%= prize.reward %>" /></label>
        <% end %>
      </div>
      <div class="add_remove_prizes">
        <button class="add" id="<%= @match.id %>-add-prize" phx-hook="AddTodo"><span>+</span></button>
        <% remove_class = if @prizes == [], do: "remove hidden", else: "remove" %>
        <button class="<%= remove_class %>" id="<%= @match.id %>-remove-prize" phx-hook="RemoveTodo"><span>-</span></button>
      </div>
      <div class="form_submit"><%= submit "Set prizes", class: "submit mx-auto rounded-lg btn-teal py-1 px-4" %></div>
    </form>
    """
  end

  def preload(assigns) do
    Enum.map(
      assigns,
      fn %{id: match_prizes_id} ->
        [match_id, _] = String.split(match_prizes_id, "-prizes", parts: 2)
        %{id: match_id, match: Freeroll.Matches.get(match_id)}
      end
    )
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    match = assigns.match
    contests = load_match_contests(match.id)
    prizes = contests |> load_prizes() |> pad_prizes_list(10)

    {:ok,
     assign(socket,
       match: match,
       contests: contests,
       prizes: prizes
     )}
  end

  def handle_event(
        "match_prizes",
        %{"prizes" => prizes, "match_id" => match_id, "league" => league},
        socket
      ) do
    # One or more prizes were sent
    contests = load_match_contests(match_id)

    Enum.each(contests, fn contest ->
      contests().update_contest(contest, %{prizes: prepare_prizes(prizes)})
    end)

    Helpers.unscoped_notification(self(), %{
      league: league,
      type: :info,
      message: "Prizes updated"
    })

    {:noreply, socket}
  end

  def handle_event("match_prizes", %{"match_id" => match_id, "league" => league}, socket) do
    # All of the prizes were removed
    contests = load_match_contests(match_id)

    Enum.each(contests, fn contest ->
      Contests.update_contest(contest, %{"prizes" => %{}})
    end)

    Helpers.unscoped_notification(self(), %{
      league: league,
      type: :info,
      message: "Prizes updated"
    })

    {:noreply, socket}
  end

  defp load_match_contests(match_uuid), do: Contests.list_contests_for_match(match_uuid)
  defp load_prizes([]), do: []

  defp load_prizes([contest | _rest]) do
    Enum.sort_by(contest.prizes, & &1.position)
  end

  defp pad_prizes_list(prizes, min_length) when length(prizes) < min_length do
    padding_length = min_length - length(prizes)
    padding = Enum.map(1..padding_length, fn _n -> %{reward: ""} end)
    prizes ++ padding
  end

  defp pad_prizes_list(prizes, _min_length), do: prizes

  defp prepare_prizes(prizes) do
    prizes
    |> Enum.filter(&(&1 != ""))
    |> Enum.with_index(1)
    |> Enum.map(fn {rew, pos} ->
      %{position: pos, reward: rew}
    end)
  end

  defp contests, do: Application.get_env(:freeroll, :contests, Freeroll.Contests)
end
