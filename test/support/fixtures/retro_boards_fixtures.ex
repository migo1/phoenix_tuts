defmodule Board.RetroBoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Board.RetroBoards` context.
  """

  @doc """
  Generate a retro_board.
  """
  def retro_board_fixture(attrs \\ %{}) do
    {:ok, retro_board} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Board.RetroBoards.create_retro_board()

    retro_board
  end
end
