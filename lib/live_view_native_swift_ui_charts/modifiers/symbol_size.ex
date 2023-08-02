defmodule LiveViewNativeSwiftUiCharts.Modifiers.SymbolSize do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue

  modifier_schema "symbol_size" do
    field :value, PlottableValue
    field :area, :float
    field :size, {:array, :float}
  end

  def params([by: value]), do: [value: value]
  def params(area) when is_number(area), do: [area: area]
  def params([x, y] = size) when is_number(x) and is_number(y), do: [size: size]
  def params(params), do: params
end
