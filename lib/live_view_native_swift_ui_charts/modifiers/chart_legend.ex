defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartLegend do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "chart_legend" do
    field :visibility, Ecto.Enum, values: ~w(automatic visible hidden)a
    field :position, Ecto.Enum, values: ~w(
      automatic
      overlay
      top
      bottom
      leading
      trailing
      top_leading
      top_trailing
      bottom_leading
      bottom_trailing
    )a, default: :automatic
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
    field :spacing, :float
    field :content, KeyName
  end

  def params(visibility) when is_atom(visibility) and not is_boolean(visibility) and not is_nil(visibility), do: [visibility: visibility]
  def params(params) when is_list(params) or is_map(params), do: params
end
