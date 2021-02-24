defmodule EmtudopayWeb.UserController do
  use EmtudopayWeb, :controller

  alias Emtudopay.User
  action_fallback EmtudopayWeb.FallbackController

  def create(conn, params) do
    params
    |> Emtudopay.create_user()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", user: user)
  end

  defp handle_response({:error, _} = error, _), do: error
end
