defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartForegroundStyleScale do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{ScaleDomain, ShapeStyle, BasicChartSymbolShape, ScaleType}
  alias LiveViewNativeSwiftUi.Types.ShapeStyle

  modifier_schema "chart_symbol_scale" do
    field :mapping, {:map, ShapeStyle}
    field :domain, ScaleDomain
    field :range, {:array, BasicChartSymbolShape}
    field :type, ScaleType
  end
end
