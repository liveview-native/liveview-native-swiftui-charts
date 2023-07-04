defmodule LiveViewNativeSwiftUiCharts.Modifiers.ChartYAxis do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "chart_y_axis" do
    field :visibility, Ecto.Enum, values: ~w(automatic visible hidden)a
    field :content, KeyName
  end

  def params(visibility) when is_atom(visibility) and not is_boolean(visibility) and not is_nil(visibility), do: [visibility: visibility]
  def params(params) when is_list(params) or is_map(params), do: params
end
