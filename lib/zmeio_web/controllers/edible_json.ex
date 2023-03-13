defmodule ZmeioWeb.EdibleJSON do
  alias Zmeio.Store.Edible

  @doc """
  Renders a list of edibles.
  """
  def index(%{edibles: edibles}) do
    %{data: for(edible <- edibles, do: data(edible))}
  end

  @doc """
  Renders a single edible.
  """
  def show(%{edible: edible}) do
    %{data: data(edible)}
  end

  defp data(%Edible{} = edible) do
    %{
      id: edible.id,
      name: edible.name,
      calories: edible.calories,
      fat: edible.fat,
      protein: edible.protein,
      carbs: edible.carbs,
      fiber: edible.fiber,
      stock: edible.stock,
      batch_price: edible.batch_price,
      batch_weight: edible.batch_weight,
    }
  end
end
