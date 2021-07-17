defmodule JsonElixirTest do
  use ExUnit.Case
  doctest JsonElixir

  test "greets the world" do
    assert JsonElixir.hello() == :world
  end
end
