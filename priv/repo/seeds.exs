# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Zmeio.Repo.insert!(%Zmeio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Zmeio.Accounts.Account
alias Zmeio.Store
alias Zmeio.Store.Edible
alias Zmeio.Store.EdibleType
alias Zmeio.Store.Order
alias Zmeio.Store.OrderItem
alias Zmeio.Store.Recipe
alias Zmeio.Store.RecipeItem
alias Zmeio.Repo

defmodule Zmeio.Seed do
  def clean() do
    Repo.delete_all(Edible)
    Repo.delete_all(EdibleType)
    Repo.delete_all(Order)
    Repo.delete_all(OrderItem)
    Repo.delete_all(Recipe)
    Repo.delete_all(RecipeItem)
  end

  def edibles() do
    # Seed Oats
    t_oat = %EdibleType{name: "oat"} |> Repo.insert!()
    [
      %Edible{name: "rolled", calories: 379.0, carbs: 67.6, fat: 6.5, fiber: 10.0, protein: 13.2, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_oat},
      %Edible{name: "quick", calories: 379.0, carbs: 67.6, fat: 6.5, fiber: 10.0, protein: 13.2, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_oat},
      %Edible{name: "steel", calories: 379.0, carbs: 67.6, fat: 6.5, fiber: 10.0, protein: 13.2, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_oat},
    ]
    |> Enum.each(fn e -> Repo.insert!(e) end)

    # Seed Nuts
    t_nut = %EdibleType{name: "nut"} |> Repo.insert!()
    [
      %Edible{name: "cashew", calories: 553.0, carbs: 30.2, fat: 43.8, fiber: 3.3, protein: 18.3, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_nut},
      %Edible{name: "pistachio", calories: 562.0, carbs: 27.2, fat: 45.3, fiber: 10.6, protein: 20.2, stock: 1000.0, batch_weight: 100.0, batch_price: 2.5, edible_type: t_nut},
      %Edible{name: "hazelnut", calories: 628.0, carbs: 16.7, fat: 60.8, fiber: 9.7, protein: 15.0, stock: 1000.0, batch_weight: 100.0, batch_price: 3.1, edible_type: t_nut},
      %Edible{name: "almond", calories: 579.0, carbs: 21.6, fat: 59.9, fiber: 12.5, protein: 21.2, stock: 1000.0, batch_weight: 100.0, batch_price: 2.7, edible_type: t_nut},
      %Edible{name: "walnut", calories: 654.0, carbs: 13.7, fat: 65.2, fiber: 6.7, protein: 15.3, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_nut},
    ]
    |> Enum.each(fn e -> Repo.insert!(e) end)

    # Seed Berries
    t_berry = %EdibleType{name: "berry"} |> Repo.insert!()
    [
      %Edible{name: "gojiberry", calories: 98.0, carbs: 21.6, fat: 0.1, fiber: 3.6, protein: 4.0, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_berry},
    ]
    |> Enum.each(fn e -> Repo.insert!(e) end)

    t_fruit = %EdibleType{name: "fruit"} |> Repo.insert!()
    [
      %Edible{name: "banana", calories: 89.0, carbs: 22.8, fat: 0.3, fiber: 2.6, protein: 1.1, stock: 1000.0, batch_weight: 100.0, batch_price: 2.2, edible_type: t_fruit},
    ]
    |> Enum.each(fn e -> Repo.insert!(e) end)
  end

  def recipes() do
    first_recipe = %Recipe{name: "WorldWind"} |> Repo.insert!()
    [
      %RecipeItem{edible: Store.get_edible_by_name("cashew"), recipe: first_recipe, batches: 1},
      %RecipeItem{edible: Store.get_edible_by_name("pistachio"), recipe: first_recipe, batches: 1},
      %RecipeItem{edible: Store.get_edible_by_name("rolled"), recipe: first_recipe, batches: 4},
    ]
    |> Enum.each(fn item -> Repo.insert(item) end)
  end

  def orders() do
    first_recipe = Store.get_recipe_by_name("WorldWind")
    first_order = %Order{} |> Repo.insert!()
    [
      %OrderItem{recipe: first_recipe, order: first_order, amount: 3}
    ]
    |> Enum.each(fn item -> Repo.insert!(item) end)
  end
end

if Mix.env() == :dev do
  Zmeio.Seed.clean
  Zmeio.Seed.edibles
  Zmeio.Seed.recipes
  Zmeio.Seed.orders
  #IO.inspect(cat_nuts)
  #IO.inspect(edibles)
end
