defmodule Emtudopay.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string
      add :birthdate, :date
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      timestamps()
    end

    create index(:users, [:email])
    create index(:users, [:nickname])
  end
end
