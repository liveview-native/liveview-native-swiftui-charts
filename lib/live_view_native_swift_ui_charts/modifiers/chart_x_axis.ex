defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartXAxis do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "chart_x_axis" do
    field :visibility, Ecto.Enum, values: ~w(automatic visible hidden)a
    field :content, KeyName
  end
end
