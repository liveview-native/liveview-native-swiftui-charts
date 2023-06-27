defmodule LiveViewNativeSwiftUiCharts.Types.ScaleRange do
  @derive Jason.Encoder
  defstruct [:padding, :start_padding, :end_padding]

  use LiveViewNativePlatform.Modifier.Type
  def type, do: :map

  def cast({:plot_dimension, padding}) when is_number(padding), do: {:ok, %__MODULE__{ padding: padding }}
  def cast({:plot_dimension, opts}) when is_list(opts) or is_map(opts) do
    opts = Enum.into(opts, %{})
    {:ok, %__MODULE__{ start_padding: Map.get(opts, :start_padding), end_padding: Map.get(opts, :end_padding) }}
  end
  def cast(:plot_dimension), do: {:ok, %__MODULE__{}}

  def cast(_), do: :error
end
