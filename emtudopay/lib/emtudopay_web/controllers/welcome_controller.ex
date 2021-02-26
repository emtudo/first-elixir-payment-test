defmodule EmtudopayWeb.WelcomeController do
  use EmtudopayWeb, :controller

  def index(conn, _) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Emtudoapy API."})
  end
end
