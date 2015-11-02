defmodule PrideFormatterTest do
  use ExUnit.Case
  doctest ExUnit.PrideFormatter

  for x <- 1..500 do
    test "the truth #{x}" do
      :timer.sleep 5
      assert 1 + 1 == 2
    end
  end
end

defmodule RainbowTest do
  use ExUnit.Case

  alias ExUnit.PrideFormatter.Rainbow

  test "colours/0" do
    assert Rainbow.colours |> :array.is_array
  end

  test "colour/1 handles lots of ints" do
    for n <- 0..10_000 do
      assert n |> Rainbow.colour |> is_integer
    end
  end
end
