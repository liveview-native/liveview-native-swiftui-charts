defmodule LiveViewNativeSwiftUiCharts.Modifiers.Annotation do
  use LiveViewNativePlatform.Modifier

  alias LiveViewNativeSwiftUiCharts.Types.AnnotationOverflowResolution
  alias LiveViewNativeSwiftUi.Types.KeyName

  modifier_schema "annotation" do
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
    )a, default: :center
    field :spacing, :float
    field :overflow_resolution, AnnotationOverflowResolution
    field :content, KeyName
  end
end
