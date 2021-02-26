defmodule EmtudopayWeb.AccountDepositControllerTest do
  use EmtudopayWeb.ConnCase, async: true
  alias Emtudopay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn_with_auth} do
      params = %{
        name: "Leandro",
        password: "12345678",
        nickname: "emtudo",
        email: "emtudo@gmail.com",
        birthdate: "2020-01-01"
      }

      {:ok, %User{account: %Account{id: account_id}}} = Emtudopay.create_user(params)

      conn = put_req_header(conn_with_auth, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id, conn_with_auth: conn_with_auth}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.account_deposit_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{"account" => %{"balance" => 50.0, "id" => _id, "user_id" => _user_id}, "message" => "Balance changed successfully"} = response
    end

    test "when there are invalid params, returns invalid deposit value", %{conn: conn, account_id: account_id} do
      params = %{"value" => "teste"}

      response =
        conn
        |> post(Routes.account_deposit_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid deposit value"} = response
    end

    test "when invalid account_id, returns account not found", %{conn: conn} do
      params = %{"value" => "50.0"}

      response =
        conn
        |> post(Routes.account_deposit_path(conn, :deposit, "b76ee49d-4c12-4c18-921b-1bc1268ebd43", params))
        |> json_response(:bad_request)

      assert %{"message" => "Account not found!"} = response
    end

    test "when users is not logged, returns unauthorized", %{conn_with_auth: conn, account_id: account_id} do
      params = %{"value" => "50.0"}

      response =
        conn
        |> post(Routes.account_deposit_path(conn, :deposit, account_id, params))
        |> response(:unauthorized)

      assert "Unauthorized" = response
    end
  end
end
