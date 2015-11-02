# ExUnit Pride

[![Build Status](https://travis-ci.org/lpil/ex-unit-pride.svg?branch=master)](https://travis-ci.org/lpil/ex-unit-pride)

Run your tests with **pride**.

## Usage

```elixir
# mix.exs
def deps do
  [
    {:ex_unit_pride, only: :test},
  ]
end
```
```elixir
# test/test_helper.exs
ExUnit.start( formatters: [ExUnit.PrideFormatter] )
```


```
mix deps.get
mix test
```
