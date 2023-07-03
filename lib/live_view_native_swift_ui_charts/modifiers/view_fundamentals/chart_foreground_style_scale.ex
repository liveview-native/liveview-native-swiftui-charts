defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartForegroundStyleScale do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{ScaleDomain, BasicChartSymbolShape, ScaleType}

  modifier_schema "chart_symbol_scale" do
    field :mapping, {:map, BasicChartSymbolShape}
    field :domain, ScaleDomain
    field :range, {:array, BasicChartSymbolShape}
    field :type, ScaleType
  end
end
