defmodule EmtudopayWeb.AccountWithdrawController do
  use EmtudopayWeb, :controller
  alias Emtudopay.Account

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Emtudopay.deposit(params) do
      conn
      |> put_status(:ok)
      |> put_view(EmtudopayWeb.AccountView)
      |> render("update.json", account: account)
    end
  end
end
