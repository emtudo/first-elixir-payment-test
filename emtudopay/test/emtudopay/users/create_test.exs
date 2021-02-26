defmodule Emtudopay.Users.CreateTest do
  use Emtudopay.DataCase

  alias Emtudopay.User
  alias Emtudopay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Leandro",
        password: "12345678",
        nickname: "emtudo",
        email: "emtudo@gmail.com",
        birthdate: "2020-01-01"
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Leandro", id: ^user_id}  = user
    end

    test "when there are invalid params, returns a error" do
      params = %{
        name: "Leandro",
        nickname: "emtudo",
        email: "emtudo@gmail.com"
      }

      {:error, changset} = Create.call(params)

      assert %{birthdate: ["can't be blank"], password: ["can't be blank"]} == errors_on(changset)
    end
  end
end
