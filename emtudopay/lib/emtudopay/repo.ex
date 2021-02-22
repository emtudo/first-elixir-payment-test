defmodule Emtudopay.Repo do
  use Ecto.Repo,
    otp_app: :emtudopay,
    adapter: Ecto.Adapters.Postgres
end
