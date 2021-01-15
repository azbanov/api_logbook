defmodule ApiLogbook.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :objectId, :string
      add :manufacturer, :string
      add :model, :string
      add :category, :string
      add :year, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:cars, [:user_id])
  end
end
