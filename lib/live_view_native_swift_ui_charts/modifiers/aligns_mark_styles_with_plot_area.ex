defmodule LiveViewNativeSwiftUiCharts.Modifiers.AlignsMarkStylesWithPlotArea do
  use LiveViewNativePlatform.Modifier

  modifier_schema "aligns_mark_styles_with_plot_area" do
    field :aligns, :boolean, default: true
  end

  def params(aligns) when is_boolean(aligns), do: [aligns: aligns]
  def params(params), do: params
end
