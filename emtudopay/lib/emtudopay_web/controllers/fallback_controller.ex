defmodule EmtudopayWeb.FallbackController do
  use EmtudopayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(EmtudopayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
