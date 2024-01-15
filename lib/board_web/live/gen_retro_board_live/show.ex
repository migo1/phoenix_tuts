defmodule BoardWeb.RetroBoardLive.Show do
  use BoardWeb, :live_view

  alias Board.RetroBoards

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:retro_board, RetroBoards.get_retro_board!(id))}
  end

  defp page_title(:show), do: "Show Retro board"
  defp page_title(:edit), do: "Edit Retro board"
end
