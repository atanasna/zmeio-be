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
      storage: edible.storage,
      stack_price: edible.stack_price,
      stack_weight: edible.stack_weight,
    }
  end
end
