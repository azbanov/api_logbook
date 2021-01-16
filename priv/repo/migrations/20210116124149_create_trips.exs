defmodule ApiLogbook.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :date, :utc_datetime
      add :place, :string
      add :aim, :string
      add :business, :integer
      add :private, :integer
      add :consumption, :float
      add :addition_expense, :float
      add :notes, :string
      add :car_id, references(:cars, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:trips, [:car_id])
  end
end
