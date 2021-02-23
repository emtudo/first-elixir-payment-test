defmodule Emtudopay.Users.Create do
  alias Emtudopay.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
