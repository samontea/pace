defmodule Pace.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pace,
     version: "0.1.1",
     elixir: "~> 1.3",

     name: "Pace",
     source_url: "https://github.com/samontea/pace",
     docs: [
       canonical: "https://hexdocs.com/pace",
       main: "Pace"
     ],

     description: description(),
     package: package(),
     deps: deps()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    Lightweight elixir performance analysis library.
    """
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end

  defp package do
    [
      name: :pace,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Samuel Mercier"],
      licenses: ["DBAD Public License"],
      links: %{
        "Github" => "https://github.com/samontea/pace"
      }
    ]
  end
end
