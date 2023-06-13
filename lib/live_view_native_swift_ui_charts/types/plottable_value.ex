defmodule LiveViewNativeSwiftUiCharts.Types.PlottableValue do
  @derive Jason.Encoder
  defstruct [:label, :value]

  use LiveViewNativePlatform.Modifier.Type
  def type, do: :map

  def cast({label, value}), do: {:ok, %__MODULE__{ label: label, value: value }}
  def cast(_), do: :error
end
