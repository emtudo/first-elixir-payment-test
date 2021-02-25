defmodule Emtudopay.Accounts.Withdraw do
  alias Emtudopay.Accounts.Operation
  alias Emtudopay.Repo

  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction (multi) do
    case Repo.transaction(multi) do
      {:error, _, reason, _} -> {:error, reason}
      {:ok, %{update_balance: account}} ->  {:ok, account}
    end
  end
end
