defmodule LiveViewNativeSwiftUiCharts.Modifiers.Symbol do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue
  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "symbol" do
    field :shape, Ecto.Enum, values: ~w(circle square triangle diamond pentagon plus cross asterisk)a
    field :value, PlottableValue
    field :symbol, KeyName
  end
end
