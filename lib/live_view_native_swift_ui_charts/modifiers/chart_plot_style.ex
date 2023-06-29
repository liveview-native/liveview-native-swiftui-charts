defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartPlotStyle do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.ModifierStack

  modifier_schema "chart_plot_style" do
    field :modifiers, ModifierStack
  end

  def params(%LiveViewNativeSwiftUi.Modifiers{} = modifiers), do: [modifiers: modifiers]
  def params(params), do: params
end
