defmodule Ambue.Contexts.UserTest do
  use Ambue.DataCase, async: true
  alias Ambue.Contexts.User
  alias Ambue.Schemas

  describe "Upsert" do
    test "We can create a user just fine thanks" do
      {:ok, %{id: id}} =
        %{name: "Ted Danson", email: "danson_with_the_stars@example.com"}
        |> Ambue.Contexts.User.upsert()

      created = Repo.get(Schemas.User, id)
      assert created.name == "Ted Danson"
      assert created.email == "danson_with_the_stars@example.com"
    end

    test "email is required" do
      %{id: id} =
        %Schemas.User{name: "Ted Danson Two", email: "danson_with_the_stars@example.com"}
        |> Repo.insert!()

      {:error, changeset} = Ambue.Contexts.User.upsert(%{name: "Joan of Arc"})

      created = Repo.get(Schemas.User, id)
      assert created.name == "Ted Danson Two"
      assert created.email == "danson_with_the_stars@example.com"
      assert changeset.errors == [email: {"can't be blank", [validation: :required]}]
    end

    test "name is required" do
      %{id: id} =
        %Schemas.User{name: "Ted Danson Two", email: "danson_with_the_stars@example.com"}
        |> Repo.insert!()

      {:error, changeset} = Ambue.Contexts.User.upsert(%{email: "test@exmapl.com"})

      created = Repo.get(Schemas.User, id)
      assert created.name == "Ted Danson Two"
      assert created.email == "danson_with_the_stars@example.com"
      assert changeset.errors == [name: {"can't be blank", [validation: :required]}]
    end
  end

  describe "get/1" do
    test "we are returned the user if they exist" do
      %{id: id} =
        %Schemas.User{name: "Ted Danson Two", email: "danson_with_the_stars@example.com"}
        |> Repo.insert!()

      user = User.get(id)
      assert user.__struct__ == Ambue.Schemas.User
      assert user.name == "Ted Danson Two"
      assert user.email == "danson_with_the_stars@example.com"
    end

    test "we are returned nil if they are not" do
      assert User.get(12) |> is_nil
    end
  end
end
