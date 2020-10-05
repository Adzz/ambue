defmodule Ambue.Contexts.User do
  alias Ambue.Schemas.User
  alias Ambue.Repo

  @doc """
  Upserts a user, applying some very basic email validations. The real validation is to send them
  an email.

  This sort of assumes that a user is already logged in and the form is more like an update details
  form. It would not be a good idea to upsert if not, as anyone could change the name of any other
  user they knew the email of.
  """
  def upsert(attrs) do
    Ecto.Changeset.cast(%User{}, attrs, User.__schema__(:fields))
    |> Ecto.Changeset.validate_required([:name, :email])
    |> Repo.insert(
      on_conflict: {:replace_all_except, [:id]},
      conflict_target: [:email],
      returning: true
    )
  end

  @doc """
  Returns nil if the user can't be found.
  """
  def get(id) do
    Repo.get(User, id)
  end
end
