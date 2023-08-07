defmodule LiveViewNativeSwiftUiCharts.Modifiers.Symbol do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{PlottableValue, BasicChartSymbolShape}
  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "symbol" do
    field :shape, BasicChartSymbolShape
    field :value, PlottableValue
    field :symbol, KeyName
  end
end
