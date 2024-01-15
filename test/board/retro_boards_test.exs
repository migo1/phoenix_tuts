defmodule Board.RetroBoardsTest do
  use Board.DataCase

  alias Board.RetroBoards

  describe "retro_boards" do
    alias Board.RetroBoards.RetroBoard

    import Board.RetroBoardsFixtures

    @invalid_attrs %{title: nil}

    test "list_retro_boards/0 returns all retro_boards" do
      retro_board = retro_board_fixture()
      assert RetroBoards.list_retro_boards() == [retro_board]
    end

    test "get_retro_board!/1 returns the retro_board with given id" do
      retro_board = retro_board_fixture()
      assert RetroBoards.get_retro_board!(retro_board.id) == retro_board
    end

    test "create_retro_board/1 with valid data creates a retro_board" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %RetroBoard{} = retro_board} = RetroBoards.create_retro_board(valid_attrs)
      assert retro_board.title == "some title"
    end

    test "create_retro_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RetroBoards.create_retro_board(@invalid_attrs)
    end

    test "update_retro_board/2 with valid data updates the retro_board" do
      retro_board = retro_board_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %RetroBoard{} = retro_board} = RetroBoards.update_retro_board(retro_board, update_attrs)
      assert retro_board.title == "some updated title"
    end

    test "update_retro_board/2 with invalid data returns error changeset" do
      retro_board = retro_board_fixture()
      assert {:error, %Ecto.Changeset{}} = RetroBoards.update_retro_board(retro_board, @invalid_attrs)
      assert retro_board == RetroBoards.get_retro_board!(retro_board.id)
    end

    test "delete_retro_board/1 deletes the retro_board" do
      retro_board = retro_board_fixture()
      assert {:ok, %RetroBoard{}} = RetroBoards.delete_retro_board(retro_board)
      assert_raise Ecto.NoResultsError, fn -> RetroBoards.get_retro_board!(retro_board.id) end
    end

    test "change_retro_board/1 returns a retro_board changeset" do
      retro_board = retro_board_fixture()
      assert %Ecto.Changeset{} = RetroBoards.change_retro_board(retro_board)
    end
  end
end
