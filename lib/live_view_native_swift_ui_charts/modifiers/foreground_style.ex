defmodule LiveViewNativeSwiftUiCharts.Modifiers.ForegroundStyle do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.PlottableValue

  modifier_schema "foreground_style" do
    field :value, PlottableValue
  end
end
