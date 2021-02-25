defmodule EmtudopayWeb.AccountView do
  alias Emtudopay.Account

  def render("update.json", %{
    account: %Account{balance: balance, user_id: user_id}
    }) do
    %{
      message: "Account updated",
      account: %{
        balance: balance,
        user_id: user_id
      }
    }
  end
end
