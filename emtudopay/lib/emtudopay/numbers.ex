defmodule Emtudopay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> IO.inspect()
      |> Enum.sum

    {:ok, %{result: result}}
  end
  defp handle_file({:error, _}), do: {:error, %{message: "Invalid file!"}}
end
