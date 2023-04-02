defmodule ZmeioWeb.GraphQL.Types.Edible do
  use Absinthe.Schema.Notation

  object :edible do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :calories, non_null(:float)
    field :carbs, non_null(:float)
    field :fat, non_null(:float)
    field :fiber, non_null(:float)
    field :protein, non_null(:float)

    #belongs_to :edible_type, Zmeio.Store.EdibleType
    #has_many :recipe_items, Zmeio.Store.RecipeItem
  end
end