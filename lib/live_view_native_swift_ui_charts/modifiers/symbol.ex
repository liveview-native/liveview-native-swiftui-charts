defmodule LiveViewNativeSwiftUiCharts.Modifiers.Symbol do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue
  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "symbol" do
    field :shape, Ecto.Enum, values: ~w(circle square triangle diamond pentagon plus cross asterisk)a
    field :value, PlottableValue
    field :symbol, KeyName
  end

  def params(shape) when is_atom(shape) and not is_boolean(shape) and not is_nil(shape), do: [shape: shape]
  def params([by: value]), do: [value: value]
  def params(params) when is_list(params) or is_map(params), do: params
end
