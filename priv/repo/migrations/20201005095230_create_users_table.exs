defmodule Ambue.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    create(table(:users)) do
      add(:name, :text, null: false)

      add(:email, :citext,
        null: false,
        comment: "The email for a user. Currently one user can have one email."
      )

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
