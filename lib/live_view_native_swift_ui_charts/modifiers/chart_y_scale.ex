defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartYScale do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.{ScaleDomain, ScaleRange, ScaleType}

  modifier_schema "chart_y_scale" do
    field :domain, ScaleDomain
    field :range, ScaleRange
    field :scale_type, ScaleType
  end
end
