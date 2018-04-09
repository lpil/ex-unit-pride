defmodule ExUnit.PrideFormatter do
  @moduledoc """
  Run your tests with pride!
  """

  alias ExUnit.CLIFormatter
  alias ExUnit.PrideFormatter.Rainbow
  use GenServer

  # Start an escape sequence
  @esc "\e["

  # End the escape sequence
  @nnd @esc <> "0m"

  def init(opts) do
    CLIFormatter.init(opts)
  end

  def handle_cast({:test_finished, %{state: {:failed, _}}} = e, s) do
    CLIFormatter.handle_cast(e, s)
  end

  def handle_cast({:test_finished, _} = msg, state) do
    colour_setting = state.colors

    colour =
      state
      |> Map.get(:test_counter, %{})
      |> Map.get(:test, 0)
      |> Rainbow.colour()

    IO.write("#{@esc}38;5;#{colour}m")
    state = %{state | colors: [enabled: false]}
    {:noreply, state} = CLIFormatter.handle_cast(msg, state)
    IO.write(@nnd)
    state = %{state | colors: colour_setting}
    {:noreply, state}
  end

  def handle_cast({:suite_finished, _, _} = msg, state) do
    CLIFormatter.handle_cast(msg, state)
  end

  def handle_cast(msg, state) do
    CLIFormatter.handle_cast(msg, state)
  end
end

defmodule ExUnit.PrideFormatter.Rainbow do
  @moduledoc """
  Mostly stolen from Minitest Pride.
  """

  granularity = 8.0
  pi_3 = :math.pi() / 3

  list =
    Enum.map(0..(6 * 7), fn n ->
      n = n / granularity
      r = trunc(3 * :math.sin(n) + 3)
      g = trunc(3 * :math.sin(n + 2 * pi_3) + 3)
      b = trunc(3 * :math.sin(n + 4 * pi_3) + 3)
      36 * r + 6 * g + b + 16
    end)

  @colours list |> :array.from_list()
  @num_colours length(list)

  def num_colours, do: @num_colours
  def colours, do: @colours

  def colour(n) when n >= 0 and n < @num_colours, do: :array.get(n, @colours)

  def colour(n) when n >= @num_colours, do: n |> rem(@num_colours) |> colour
end
