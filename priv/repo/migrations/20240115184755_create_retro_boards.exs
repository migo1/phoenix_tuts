defmodule Board.Repo.Migrations.CreateRetroBoards do
  use Ecto.Migration

  def change do
    create table(:retro_boards) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
