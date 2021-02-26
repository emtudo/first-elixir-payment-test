defmodule EmtudopayWeb.AccountView do
  alias Emtudopay.Account
  alias Emtudopay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{
    account: %Account{
      id: id, balance: balance, user_id: user_id}
    }) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: Decimal.to_float(balance),
        user_id: user_id
      }
    }
  end

  def render("transaction.json", %{
    transaction: %TransactionResponse{to_account: to_account, from_account: from_account}
    }) do
    %{
      message: "Transaction done successfully",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: Decimal.to_float(from_account.balance),
          user_id: from_account.user_id
        },
        to_account: %{
          id: to_account.id,
          balance: Decimal.to_float(to_account.balance),
          user_id: to_account.user_id
        }
      }
    }
  end
end
