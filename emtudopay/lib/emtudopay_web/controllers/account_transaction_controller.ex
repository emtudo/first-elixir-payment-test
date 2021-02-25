defmodule EmtudopayWeb.AccountTransactionController do
  use EmtudopayWeb, :controller
  action_fallback EmtudopayWeb.FallbackController
  alias Emtudopay.Accounts.Transactions.Response, as: TransactionResponse
  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <- Emtudopay.transaction(params) do
      conn
      |> put_status(:ok)
      |> put_view(EmtudopayWeb.AccountView)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
