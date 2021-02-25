defmodule EmtudopayWeb.AccountDepositController do
  use EmtudopayWeb, :controller
  alias Emtudopay.Account
  action_fallback EmtudopayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Emtudopay.deposit(params) do
      conn
      |> put_status(:ok)
      |> put_view(EmtudopayWeb.AccountView)
      |> render("update.json", account: account)
    end
  end
end
