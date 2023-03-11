defmodule ZmeioWeb.EdibleTypeJSON do
  alias Zmeio.EdibleTypes.EdibleType

  @doc """
  Renders a list of edible_types.
  """
  def index(%{edible_types: edible_types}) do
    %{data: for(edible_type <- edible_types, do: data(edible_type))}
  end

  @doc """
  Renders a single edible_type.
  """
  def show(%{edible_type: edible_type}) do
    %{data: data(edible_type)}
  end

  defp data(%EdibleType{} = edible_type) do
    %{
      id: edible_type.id,
      name: edible_type.name
    }
  end
end
