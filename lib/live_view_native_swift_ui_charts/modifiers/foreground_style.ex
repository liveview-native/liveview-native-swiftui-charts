defmodule LiveViewNativeSwiftUiCharts.Modifiers.ForegroundStyle do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue
  alias LiveViewNativeSwiftUi.Types.ShapeStyle

  modifier_schema "foreground_style" do
    field :value, PlottableValue

    field :primary, ShapeStyle
    field :secondary, ShapeStyle
    field :tertiary, ShapeStyle
  end
end
