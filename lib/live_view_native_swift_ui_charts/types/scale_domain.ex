defmodule LiveViewNativeSwiftUiCharts.Types.ScaleDomain do
  @derive Jason.Encoder
  defstruct [:type, :includes_zero, :reversed, :lower_bound, :upper_bound, :values]

  use LiveViewNativePlatform.Modifier.Type
  def type, do: :map

  def cast(:automatic = type), do: {:ok, %__MODULE__{ type: type }}

  def cast({:automatic = type, opts}) do
    opts = Enum.into(opts, %{})
    {:ok, %__MODULE__{ type: type, includes_zero: Map.get(opts, :includes_zero), reversed: Map.get(opts, :reversed) }}
  end

  def cast({lower_bound, upper_bound}) when is_number(lower_bound) and is_number(upper_bound) do
    {:ok, %__MODULE__{ type: :numeric_range, lower_bound: lower_bound, upper_bound: upper_bound }}
  end

  def cast({lower_bound, upper_bound}) when is_struct(lower_bound, DateTime) and is_struct(upper_bound, DateTime) do
    {:ok, %__MODULE__{ type: :date_range, lower_bound: lower_bound, upper_bound: upper_bound }}
  end

  def cast(values) when is_list(values), do: {:ok, %__MODULE__{ type: :values, values: values }}

  def cast(_), do: :error
end
