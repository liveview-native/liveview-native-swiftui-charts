defmodule LiveViewNativeSwiftUiCharts.Types.AnnotationPosition do
  use LiveViewNativePlatform.Modifier.Type
  def type, do: :string

  @positions_atom [
    :automatic,
    :bottom,
    :bottom_leading,
    :bottom_trailing,
    :leading,
    :overlay,
    :top,
    :top_leading,
    :top_trailing,
    :trailing,
  ]

  @positions_string [
    "automatic",
    "bottom",
    "bottom-leading",
    "bottom-trailing",
    "leading",
    "overlay",
    "top",
    "top-leading",
    "top-trailing",
    "trailing",
  ]

  def cast(value) when is_atom(value) and value in @positions_atom, do: {:ok, Atom.to_string(value)}
  def cast(value) when is_binary(value) and value in @positions_string, do: {:ok, value}
  def cast(_), do: :error
end
