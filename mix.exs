defmodule ExUnitPride.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_unit_pride,
      version: @version,
      elixir: "~> 1.6",
      deps: deps(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "ExUnit Pride",
      source_url: "https://github.com/lpil/ex-unit-pride",
      description: "Run your tests with pride",
      package: [
        maintainers: ["Louis Pilfold"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/lpil/ex-unit-pride"}
      ]
    ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
      # Automatic test runner
      {:mix_test_watch, "~> 0.1", only: :dev}
    ]
  end
end
