defmodule LiveViewNativeSwiftUiCharts.Modifiers.InterpolationMethod do
  use LiveViewNativePlatform.Modifier

  modifier_schema "interpolation_method" do
    field :method, Ecto.Enum, values: ~w(cardinal catmull_rom linear monotone step_center step_end step_start)a
  end

  def params(method) when is_atom(method), do: [method: method]
  def params(params), do: params
end
