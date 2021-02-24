defmodule EmtudopayWeb.UserController do
  use EmtudopayWeb, :controller

  alias Emtudopay.User
  action_fallback EmtudopayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Emtudopay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
