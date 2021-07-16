defmodule JsonElixirTest do
  use ExUnit.Case
  doctest JsonElixir

  test "to_html/1 invalid input nil",
    do: assert(JsonElixir.to_html(nil) == {:error, "expected list or bit string got: nil"})

  test "to_html!/1 invalid input nil",
    do: assert_raise(ArgumentError, fn -> JsonElixir.to_html!(nil) end)

  test "to_html/1 invalid input %{}",
    do: assert(JsonElixir.to_html(%{}) == {:error, "expected list or bit string got: %{}"})

  test "to_html!/1 invalid input %{}",
    do: assert_raise(ArgumentError, fn -> JsonElixir.to_html!(%{}) end)

  test "to_html/1 invalid input []",
    do: assert(JsonElixir.to_html([]) == {:error, :unexpected_end_of_buffer})

  test "to_html!/1 invalid input []",
    do: assert_raise(ArgumentError, fn -> JsonElixir.to_html!([]) end)

  test "to_html/1 valid input",
    do:
      assert(
        JsonElixir.to_html(~s(
      {
        "headers": {
          "Content-Type": "application/json"
        }
      }
    )) ==
          {:ok,
           "<table><tr><td></td><td>%{</td></tr><tr><td></td><td></td><td>headers:</td><td><tr><td></td><td>%{</td></tr><tr><td></td><td></td><td>Content-Type:</td><td>application/json,</td></tr><tr><td></td><td>}%</td></tr></td></tr><tr><td></td><td>}%</td></tr></table>"}
      )

  test "to_html!/1 input",
    do:
      assert(
        JsonElixir.to_html!(~s({"a": 1})) ==
          "<table><tr><td></td><td>%{</td></tr><tr><td></td><td></td><td>a:</td><td>1,</td></tr><tr><td></td><td>}%</td></tr></table>"
      )
end
