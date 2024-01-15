defmodule BoardWeb.RetroBoardLive.Index do
  use BoardWeb, :live_view

  alias Board.RetroBoards
  alias Board.RetroBoards.RetroBoard

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :retro_boards, RetroBoards.list_retro_boards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Retro board")
    |> assign(:retro_board, RetroBoards.get_retro_board!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Retro board")
    |> assign(:retro_board, %RetroBoard{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Retro boards")
    |> assign(:retro_board, nil)
  end

  @impl true
  def handle_info({BoardWeb.RetroBoardLive.FormComponent, {:saved, retro_board}}, socket) do
    {:noreply, stream_insert(socket, :retro_boards, retro_board)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    retro_board = RetroBoards.get_retro_board!(id)
    {:ok, _} = RetroBoards.delete_retro_board(retro_board)

    {:noreply, stream_delete(socket, :retro_boards, retro_board)}
  end
end
