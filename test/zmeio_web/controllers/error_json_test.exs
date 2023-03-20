defmodule ZmeioWeb.ErrorJSONTest do
  use ZmeioWeb.ConnCase, async: true

  test "renders 404" do
    assert ZmeioWeb.ErrorViewJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ZmeioWeb.ErrorViewJSON.render("500.json", %{}) == %{errors: %{detail: "Internal Server Error"}}
  end
end
