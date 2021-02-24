defmodule Emtudopay.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  alias Emtudopay.Account

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :birthdate, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :birthdate, :date
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string
    has_one :account, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changset), do: changset
end
