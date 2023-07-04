defmodule LiveViewNativeSwiftUiCharts.Modifiers.LineStyle do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue
  alias LiveViewNativeSwiftUi.Types.StrokeStyle

  modifier_schema "line_style" do
    field :style, StrokeStyle
    field :value, PlottableValue
  end

  def params([by: value]), do: [value: value]
  def params(params) when is_map(params) or is_list(params) do
    with {:ok, _} <- StrokeStyle.cast(params) do
      [style: params]
    else
      :error ->
        params
    end
  end
end
