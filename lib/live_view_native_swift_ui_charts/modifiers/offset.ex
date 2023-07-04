defmodule LiveViewNativeSwiftUiCharts.Modifiers.Offset do
  use LiveViewNativePlatform.Modifier

  modifier_schema "offset" do
    field :x, :float, default: nil
    field :y, :float, default: nil

    field :x_start, :float, default: nil
    field :x_end, :float, default: nil

    field :y_start, :float, default: nil
    field :y_end, :float, default: nil
  end
end
