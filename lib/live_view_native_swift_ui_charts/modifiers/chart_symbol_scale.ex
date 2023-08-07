defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartSymbolScale do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{ScaleDomain, BasicChartSymbolShape}

  modifier_schema "chart_symbol_scale" do
    field :domain, ScaleDomain
    field :range, {:array, BasicChartSymbolShape}
    field :mapping, {:map, BasicChartSymbolShape}
  end
end
