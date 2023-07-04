defmodule LiveViewNativeSwiftUiCharts.Modifiers.CornerRadius do
  use LiveViewNativePlatform.Modifier

  modifier_schema "corner_radius" do
    field :radius, :float
    field :style, Ecto.Enum, values: ~w(circular continuous)a, default: :continuous

    field :antialiased, :boolean, default: true
  end

  def params(radius, [style: style]) when is_number(radius) and is_atom(style) and not is_boolean(style) and not is_nil(style), do: [radius: radius, style: style]
  def params(radius) when is_number(radius), do: [radius: radius]
  def params(params), do: params
end
