defmodule Board.RetroBoards.RetroBoard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "retro_boards" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(retro_board, attrs) do
    retro_board
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
