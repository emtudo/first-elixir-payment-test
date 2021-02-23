defmodule Emtudopay do
  alias Emtudopay.Users.Create, as: UserCreate
  defdelegate create_user(params), to: UserCreate, as: :call
end
