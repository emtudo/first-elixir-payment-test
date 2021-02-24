defmodule EmtudopayWeb.WelcomeController do
  use EmtudopayWeb, :controller
  alias Emtudopay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> IO.inspect()
    |> json(%{message: "Welcome to Emtudoapy API. Here is your number #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end
end