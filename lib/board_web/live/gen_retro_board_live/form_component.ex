defmodule BoardWeb.RetroBoardLive.FormComponent do
  use BoardWeb, :live_component

  alias Board.RetroBoards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage retro_board records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="retro_board-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Retro board</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{retro_board: retro_board} = assigns, socket) do
    changeset = RetroBoards.change_retro_board(retro_board)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"retro_board" => retro_board_params}, socket) do
    changeset =
      socket.assigns.retro_board
      |> RetroBoards.change_retro_board(retro_board_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"retro_board" => retro_board_params}, socket) do
    save_retro_board(socket, socket.assigns.action, retro_board_params)
  end

  defp save_retro_board(socket, :edit, retro_board_params) do
    case RetroBoards.update_retro_board(socket.assigns.retro_board, retro_board_params) do
      {:ok, retro_board} ->
        notify_parent({:saved, retro_board})

        {:noreply,
         socket
         |> put_flash(:info, "Retro board updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_retro_board(socket, :new, retro_board_params) do
    case RetroBoards.create_retro_board(retro_board_params) do
      {:ok, retro_board} ->
        notify_parent({:saved, retro_board})

        {:noreply,
         socket
         |> put_flash(:info, "Retro board created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
