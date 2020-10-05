defmodule AmbueWeb.PageLive do
  use AmbueWeb, :live_view
  alias Ambue.Contexts.User

  @impl true
  @doc """
  If you provide a valid user id in the params, we will load that users details. Obviously this
  has security implications, and lacking a proper auth system this is a bad idea. But for a contrived
  app this is fine.

  If we can't find one, we just assume you are starting anew. Again, not a great idea, we may want
  to differentiate between not providing a user id at all and providing one that points to nowhere.

  IRL I would also use UUIDs so that the url params are not guessable.
  """
  def mount(params = %{"id" => id}, _session, socket) do
    case User.get(id) do
      %Ambue.Schemas.User{email: email, name: name} ->
        {:ok, assign(socket, user: %{name: name, email: email}, error: nil)}

      nil ->
        {:ok, assign(socket, user: %{name: "", email: ""}, error: nil)}
    end
  end

  def mount(_, _session, socket) do
    {:ok, assign(socket, user: %{name: "", email: ""}, error: nil)}
  end

  @impl true
  def handle_event("update", params = %{"user_name" => name, "user_email" => email}, socket) do
    {:noreply, assign(socket, user: %{name: name, email: email}, error: nil)}
  end

  def handle_event("save", params = %{"user_name" => name, "user_email" => email}, socket) do
    case User.upsert(%{name: name, email: email}) do
      {:ok, %{name: name, email: email}} ->
        {:noreply, assign(socket, user: %{name: name, email: email}, error: nil)}

      {:error, changeset} ->
        # This could / should be a generic helper.
        message =
          changeset
          |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
          |> Enum.map(fn
            {k, v} when is_list(v) -> "#{k}: #{Enum.join(v, "\n")}"
            {k, v} -> "#{k}: #{v}"
          end)

        {:noreply, assign(socket, user: %{name: name, email: email}, error: message)}
    end
  end
end
