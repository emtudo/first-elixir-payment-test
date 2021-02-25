defmodule EmtudopayWeb.AccountView do
  alias Emtudopay.Account

  def render("update.json", %{
    account: %Account{
      id: id, balance: balance, user_id: user_id}
    }) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: balance,
        user_id: user_id
      }
    }
  end
end
