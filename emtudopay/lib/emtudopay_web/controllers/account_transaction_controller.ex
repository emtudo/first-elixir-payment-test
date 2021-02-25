defmodule EmtudopayWeb.AccountTransactionController do
  use EmtudopayWeb, :controller
  # alias Emtudopay.Transaction

  def transaction(conn, params) do
    with {:ok, %{} = transaction} <- Emtudopay.transaction(params) do
      conn
      |> put_status(:ok)
      |> put_view(EmtudopayWeb.AccountView)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
