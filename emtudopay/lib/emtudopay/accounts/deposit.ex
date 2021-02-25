defmodule Emtudopay.Accounts.Deposit do
  alias Ecto.Multi
  alias Emtudopay.{Account, Repo}

  def call(%{"id" => id, "value" => value} = _) do
    Multi.new()
    |> Multi.run(:account, fn repo, _ -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
     end)
    |> run_transaction()
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> handle_cast(balance)
  end

  defp handle_cast({:ok, %Decimal{ sign: 1} = value}, balance), do: Decimal.add(value, balance)
  defp handle_cast(_, _), do: {:error, "Invalid deposit value"}

  defp update_account({:error, _} = error, _, _), do: error

  defp update_account(value, repo, account) do
    params = %{balance: value}
    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction (multi) do
    case Repo.transaction(multi) do
      {:error, _, reason, _} -> {:error, reason}
      {:ok, %{update_balance: account}} ->  {:ok, account}
    end
  end
end
