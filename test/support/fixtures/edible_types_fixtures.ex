defmodule Zmeio.EdibleTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Store` context.
  """

  @doc """
  Generate a edible_type.
  """
  def edible_type_fixture(attrs \\ %{}) do
    {:ok, edible_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Zmeio.Store.create_edible_type()

    edible_type
  end
end
