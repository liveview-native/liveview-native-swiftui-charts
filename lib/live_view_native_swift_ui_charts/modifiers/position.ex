defmodule LiveViewNativeSwiftUiCharts.Modifiers.Position do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{PlottableValue, MarkDimension}

  modifier_schema "position" do
    field :value, PlottableValue
    field :axis, Ecto.Enum, values: ~w(horizontal vertical all)a
    field :span, MarkDimension

    field :x, :float, default: 0.0
    field :y, :float, default: 0.0
  end

  def params([by: value]), do: [value: value]
  def params(params) when is_list(params) or is_map(params) do
    params = Enum.into(params, %{})
    Map.put_new(params, :value, Map.get(params, :by))
  end
end
