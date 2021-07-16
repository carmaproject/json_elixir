defmodule JsonElixir do

  alias JsonElixir.Process

   @moduledoc ~S"""
    JSON Elixir is tool to convert json into HTML
  """

  @doc """
  Returns a JSON string representation of the Elixir term
  ## Examples
    iex> JsonElixir.to_html!(~s({"a": 1}))
    "<table><tr><td></td><td>%{</td></tr><tr><td></td><td></td><td>a:</td><td>1,</td></tr><tr><td></td><td>}%</td></tr></table>"
  """
  defdelegate to_html!(json), to: Process

  @doc """
  Returns a JSON string representation of the Elixir term
  ## Examples
    iex> JsonElixir.to_html(~s({"a": 1}))
    {:ok, "<table><tr><td></td><td>%{</td></tr><tr><td></td><td></td><td>a:</td><td>1,</td></tr><tr><td></td><td>}%</td></tr></table>"}
  """
  defdelegate to_html(json), to: Process

end
