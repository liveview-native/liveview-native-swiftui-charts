defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartXAxisLabel do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.AnnotationPosition

  modifier_schema "chart_x_axis_label" do
    field :title, :string, default: nil
    field :position, AnnotationPosition
    field :alignment, Ecto.Enum, values: ~w(
      bottom
      bottom_leading
      bottom_trailing
      center
      leading
      leading_last_text_baseline
      top
      top_leading
      top_trailing
      trailing
      trailing_first_text_baseline
    )a
    field :spacing, :float, default: nil
    field :content, :string, default: nil
  end
end
