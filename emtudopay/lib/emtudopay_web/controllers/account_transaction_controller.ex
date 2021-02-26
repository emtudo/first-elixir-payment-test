defmodule EmtudopayWeb.AccountTransactionController do
  use EmtudopayWeb, :controller
  action_fallback EmtudopayWeb.FallbackController
  alias Emtudopay.Accounts.Transactions.Response, as: TransactionResponse
  def transaction(conn, params) do
    task = Task.async(fn -> Emtudopay.transaction(params) end)
    result = Task.await(task)

    #  conn
    #  |> put_status(:ok)
    #  |> json(%{message: "Transaction is scheduled"})

    with {:ok, %TransactionResponse{} = transaction} <- result do
      conn
      |> put_status(:ok)
      |> put_view(EmtudopayWeb.AccountView)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
