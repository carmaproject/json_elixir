defmodule JsonElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :json_elixir,
      version: "0.1.1",
     # elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/carmaproject/json_elixir"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:json, "~> 1.4"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  def package do
    [
      # name: "ex_json",
      maintainers: "hassanRSiddiqi",
      organization: "carmaproject",
      licenses: ["MIT License"],
    ]
  end

  defp description() do
    "Convert raw json into html."
  end
end
