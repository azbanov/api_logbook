defmodule ApiLogbook.Repo.Migrations.ChangeTripsDateToNaiveDatetime do
  use Ecto.Migration

  def change do
    alter table(:trips) do
      modify :notes, :text
    end
  end
end
