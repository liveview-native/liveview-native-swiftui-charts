defmodule LiveViewNativeSwiftUiCharts.Types.AnnotationOverflowResolution do
  use LiveViewNativePlatform.Modifier.Type
  def type, do: :array

  def cast({x, y}), do: {:ok, [cast_strategy(x), cast_strategy(y)]}
  def cast(_), do: :error

  def cast_strategy(type) when is_atom(type), do: type
  def cast_strategy({:fit = type, boundary}), do: [type, boundary]
end
