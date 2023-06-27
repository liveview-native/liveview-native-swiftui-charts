defmodule LiveViewNativeSwiftUiCharts.Types.ScaleType do
  use LiveViewNativePlatform.Modifier.Type
  def type, do: :any

  def cast(type) when is_atom(type), do: {:ok, type}
  def cast({:power = type, exponent}), do: {:ok, [type, exponent]}
  def cast({:symmetric_log = type, slope_at_zero}), do: {:ok, [type, slope_at_zero]}

  def cast(_), do: :error
end
