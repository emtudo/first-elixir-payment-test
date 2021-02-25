defmodule Emtudopay.Accounts.Operation do
  alias Ecto.Multi
  alias Emtudopay.Account

  def call(%{"id" => id, "value" => value}, operation) do
    operation_name = account_operation_name(operation)
    Multi.new()
    |> Multi.run(operation_name, fn repo, _ -> get_account(repo, id) end)
    |> Multi.run(operation, fn repo, changes ->
      account = Map.get(changes, operation_name)
      update_balance(repo, account, value, operation)
     end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    account
    |> operation(value, operation)
    |> update_account(repo, account)
  end

  defp operation(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, %Decimal{ sign: 1} = value}, balance, :deposit), do: Decimal.add(value, balance)
  defp handle_cast({:ok, %Decimal{ sign: 1} = value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(_, _balance, _operation), do: {:error, "Invalid deposit value"}

  defp update_account({:error, _} = error, _, _), do: error

  defp update_account(value, repo, account) do
    params = %{balance: value}
    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp account_operation_name(operation) do
    "account_#{Atom.to_string(operation)}"
    |> String.to_atom()
  end
end
