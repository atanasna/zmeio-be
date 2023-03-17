defmodule ZmeioWeb.AuthControllerTest do
  use ZmeioWeb.ConnCase

  alias Zmeio.Repo
  alias Zmeio.Identity.User

  @ueberauth_auth %{
    credentials: %{token: "fdsnoafhnoofh08h38h"},
    info: %{
      email: "ironman@example.com",
      first_name: "Tony",
      last_name: "Stark"},
    provider: "google"
  }

  describe "local user registration" do
    test "with valid inputs", %{conn: conn} do
      pre_user_count = Zmeio.Identity.list_users |> Enum.count()
      register_valid_attrs = %{
        email: "jdoe@gmail.com",
        first_name: "John",
        last_name: "Doe",
        password: "alabala"
      }

      conn = post(conn, ~p"/api/auth/local/register", register_valid_attrs)
      resp = json_response(conn, 201)

      post_user_count = Zmeio.Identity.list_users |> Enum.count()

      assert resp["first_name"] == register_valid_attrs.first_name
      assert resp["last_name"] == register_valid_attrs.last_name
      assert resp["email"] == register_valid_attrs.email
      assert resp["provider"] == "local"
      assert post_user_count == pre_user_count + 1
    end

    test "with invalid inputs", %{conn: conn} do
      register_invalid_attrs = %{
        email: "jdoe",
        first_name: "John",
        last_name: "Doe",
        password: "alabala"
      }

      conn = post(conn, ~p"/api/auth/local/register", register_invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "local user login" do
    test "with valid credentials", %{conn: conn} do
      %{
        first_name: "John",
        last_name: "Doe",
        email: "jd@gmail.com",
        password_hash: Bcrypt.hash_pwd_salt("pass"),
        provider: "local"
      }
      |> Zmeio.Identity.create_user()

      conn = post(conn, ~p"/api/auth/local/login", %{email: "jd@gmail.com", password: "pass"})
      resp = json_response(conn, 200)

      assert resp["email"] == "jd@gmail.com"
      assert resp["token"] |> String.match?(~r/\S{100,}/)
    end

    test "with invalid credentials", %{conn: conn} do
      %{
        first_name: "John",
        last_name: "Doe",
        email: "jd@gmail.com",
        password_hash: Bcrypt.hash_pwd_salt("pass"),
        provider: "local"
      }
      |> Zmeio.Identity.create_user()

      conn = post(conn, ~p"/api/auth/local/login", %{email: "jd@gmail.com", password: "Wrong_pass"})
      resp = json_response(conn, 401)

      assert resp["errors"] != []
    end
  end

  #setup %{conn: conn} do
  #  {:ok, conn: put_req_header(conn, "accept", "application/json")}
  #end

  #test "redirects user to Google for authentication", %{conn: conn} do
  #  conn = get(conn, "/auth/google?scope=email%20profile")
  #  assert redirected_to(conn, 302)
  #end
  #decsribe "Oauth" do
  #  test "creates user from Google information", %{conn: conn} do
  #    users_count_pre = User |> Repo.all |> Enum.count()
#
  #    conn = conn
  #    |> assign(:ueberauth_auth, @ueberauth_auth)
  #    |> get("/api/auth/google/callback")
  ##
  #    #IO.inspect conn
  #    users_count_post = User |> Repo.all |> Enum.count()
  #    assert users_count_post == users_count_pre + 1
  #    #assert get_flash(conn, :info) == "Thank you for signing in!"
  #  end
  #end
end
