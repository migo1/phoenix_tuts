defmodule BoardWeb.RetroBoardLiveTest do
  use BoardWeb.ConnCase

  import Phoenix.LiveViewTest
  import Board.RetroBoardsFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_retro_board(_) do
    retro_board = retro_board_fixture()
    %{retro_board: retro_board}
  end

  describe "Index" do
    setup [:create_retro_board]

    test "lists all retro_boards", %{conn: conn, retro_board: retro_board} do
      {:ok, _index_live, html} = live(conn, ~p"/retro_boards")

      assert html =~ "Listing Retro boards"
      assert html =~ retro_board.title
    end

    test "saves new retro_board", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/retro_boards")

      assert index_live |> element("a", "New Retro board") |> render_click() =~
               "New Retro board"

      assert_patch(index_live, ~p"/retro_boards/new")

      assert index_live
             |> form("#retro_board-form", retro_board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#retro_board-form", retro_board: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/retro_boards")

      html = render(index_live)
      assert html =~ "Retro board created successfully"
      assert html =~ "some title"
    end

    test "updates retro_board in listing", %{conn: conn, retro_board: retro_board} do
      {:ok, index_live, _html} = live(conn, ~p"/retro_boards")

      assert index_live |> element("#retro_boards-#{retro_board.id} a", "Edit") |> render_click() =~
               "Edit Retro board"

      assert_patch(index_live, ~p"/retro_boards/#{retro_board}/edit")

      assert index_live
             |> form("#retro_board-form", retro_board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#retro_board-form", retro_board: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/retro_boards")

      html = render(index_live)
      assert html =~ "Retro board updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes retro_board in listing", %{conn: conn, retro_board: retro_board} do
      {:ok, index_live, _html} = live(conn, ~p"/retro_boards")

      assert index_live |> element("#retro_boards-#{retro_board.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#retro_boards-#{retro_board.id}")
    end
  end

  describe "Show" do
    setup [:create_retro_board]

    test "displays retro_board", %{conn: conn, retro_board: retro_board} do
      {:ok, _show_live, html} = live(conn, ~p"/retro_boards/#{retro_board}")

      assert html =~ "Show Retro board"
      assert html =~ retro_board.title
    end

    test "updates retro_board within modal", %{conn: conn, retro_board: retro_board} do
      {:ok, show_live, _html} = live(conn, ~p"/retro_boards/#{retro_board}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Retro board"

      assert_patch(show_live, ~p"/retro_boards/#{retro_board}/show/edit")

      assert show_live
             |> form("#retro_board-form", retro_board: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#retro_board-form", retro_board: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/retro_boards/#{retro_board}")

      html = render(show_live)
      assert html =~ "Retro board updated successfully"
      assert html =~ "some updated title"
    end
  end
end
