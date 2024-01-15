defmodule Board.RetroBoards do
  @moduledoc """
  The RetroBoards context.
  """

  import Ecto.Query, warn: false
  alias Board.Repo

  alias Board.RetroBoards.RetroBoard

  @doc """
  Returns the list of retro_boards.

  ## Examples

      iex> list_retro_boards()
      [%RetroBoard{}, ...]

  """
  def list_retro_boards do
    Repo.all(RetroBoard)
  end

  @doc """
  Gets a single retro_board.

  Raises `Ecto.NoResultsError` if the Retro board does not exist.

  ## Examples

      iex> get_retro_board!(123)
      %RetroBoard{}

      iex> get_retro_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retro_board!(id), do: Repo.get!(RetroBoard, id)

  @doc """
  Creates a retro_board.

  ## Examples

      iex> create_retro_board(%{field: value})
      {:ok, %RetroBoard{}}

      iex> create_retro_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_retro_board(attrs \\ %{}) do
    %RetroBoard{}
    |> RetroBoard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a retro_board.

  ## Examples

      iex> update_retro_board(retro_board, %{field: new_value})
      {:ok, %RetroBoard{}}

      iex> update_retro_board(retro_board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retro_board(%RetroBoard{} = retro_board, attrs) do
    retro_board
    |> RetroBoard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a retro_board.

  ## Examples

      iex> delete_retro_board(retro_board)
      {:ok, %RetroBoard{}}

      iex> delete_retro_board(retro_board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retro_board(%RetroBoard{} = retro_board) do
    Repo.delete(retro_board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retro_board changes.

  ## Examples

      iex> change_retro_board(retro_board)
      %Ecto.Changeset{data: %RetroBoard{}}

  """
  def change_retro_board(%RetroBoard{} = retro_board, attrs \\ %{}) do
    RetroBoard.changeset(retro_board, attrs)
  end
end
