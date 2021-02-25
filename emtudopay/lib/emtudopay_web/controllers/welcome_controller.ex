defmodule EmtudopayWeb.WelcomeController do
  use EmtudopayWeb, :controller

  def index(conn, _) do
    conn
    |> put_status(:ok)
    |> IO.inspect()
    |> json(%{message: "Welcome to Emtudoapy API."})
  end
end
