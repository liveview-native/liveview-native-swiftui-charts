defmodule LiveViewNativeSwiftUiCharts.Types.MarkDimension do
  @derive Jason.Encoder
  defstruct [:type, :value]

  use LiveViewNativePlatform.Modifier.Type
  def type, do: :map

  def cast(:automatic = type), do: cast({type, 0})
  def cast({type, value}), do: {:ok, %__MODULE__{ type: type, value: value }}
  def cast(_), do: :error
end
