defmodule EmtudopayWeb.UserViewTest do
  use EmtudopayWeb.ConnCase
  import Phoenix.View
  alias Emtudopay.User
  alias Emtudopay.Account

  test "renders create.json" do
    params = %{
      name: "Leandro",
      password: "12345678",
      nickname: "emtudo",
      email: "emtudo@gmail.com",
      birthdate: "2020-01-01"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Emtudopay.create_user(params)
    response = render(EmtudopayWeb.UserView, "create.json", user: user)

    assert %{
      message: "User created",
      user: %{
        account: %{
          balance: 0.0,
          id: account_id
        },
        id: user_id,
        name: "Leandro",
        nickname: "emtudo"
      }
    } == response
  end
end
