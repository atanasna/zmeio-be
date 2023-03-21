defmodule Zmeio.UsersTest do
  use Zmeio.DataCase

  alias Zmeio.Identity

  describe "users" do
    alias Zmeio.Identity.User

    import Zmeio.UsersFixtures

    @invalid_attrs %{email: "pesho12"}

    test "list_users/0 returns all users" do
      fixed_user = user_fixture()
      assert Identity.list_users() |> Enum.count == 1
    end

    test "get_user!/1 returns the user with given id" do
      fixed_user = user_fixture()
      user = Identity.get_user!(fixed_user.id)

      assert user.id == fixed_user.id
      assert user.password_hash == fixed_user.password_hash
      assert user.email == fixed_user.email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "nasko@abv.bg", password: "naskonaskonasko", password_confirmation: "naskonaskonasko", provider: "local"}
      {:ok, %User{} = user} = Identity.create_user(valid_attrs)

      assert user.email == "nasko@abv.bg"
      assert user.password_hash |> String.match?(~r/^\$2b/)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Identity.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      fixed_user = user_fixture()
      update_attrs = %{first_name: "Nasko", last_name: "Naskov", email: "nasko@abv.bg", provider: "local"}

      {:ok, update_user} = Identity.update_user(fixed_user, update_attrs)

      assert update_user.email == "nasko@abv.bg"
      assert update_user.first_name == "Nasko"
      assert update_user.last_name == "Naskov"
      assert update_user.provider == "local"
    end

    test "update_user/2 with invalid data returns error changeset" do
      fixed_user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Identity.update_user(fixed_user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Identity.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Identity.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Identity.change_user(user)
    end
  end
end
