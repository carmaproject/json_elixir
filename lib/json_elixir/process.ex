defmodule JsonElixir.Process do

  @invalid_input "expected list or bit string got: "

  def to_html!(json) when is_list(json) or is_bitstring(json) do
    case JSON.decode(json) do
      {:ok, json} ->
        process(json)
      {:error, _error} ->
        raise ArgumentError, @invalid_input <> inspect json
    end
  end

  def to_html!(json), do: raise ArgumentError, @invalid_input <> inspect json

  def to_html(json) when is_list(json) or is_bitstring(json) do
    case JSON.decode(json) do
      {:ok, json} ->
        {:ok, process(json)}
      {:error, error} ->
        {:error, error}
    end
  end

  def to_html(json), do: {:error, @invalid_input <> inspect json}

  defp process(json) do
    str = ["<table>", parse_json(json), "</table>")] |> IO.chardata_to_string()

    String.replace(str, ~r/[\x{200B}\x{200C}\x{200D}\x{FEFF}\\\r\n\\"]/u, "")
  end

  defp parse_json(value) when is_nil(value), do: []

  defp parse_json(value) when
  is_bitstring(value) or
  is_number(value) or
  is_boolean(value) or
  is_list(value) and length(value) == 0
  do

    decorate_with_span(value)
  end

  defp parse_json(value) when is_list(value) do
      value = Enum.map(value, fn v ->
        html = parse_json(v)
        ["<tr><td></td>", html, "<td></td></tr>"] |> IO.chardata_to_string()
      end)

      ["<tr><td></td><td>[</td></tr>", value, "<tr><td></td><td>]</td></tr>"] |> IO.chardata_to_string()
  end

  defp parse_json(value) do
    value = Enum.map(value, fn {k, v} ->
      ["<tr><td></td><td></td><td>", k, ":</td><td>", parse_json(v), "</td></tr>"] |> IO.chardata_to_string()
    end)

    ["<tr><td></td><td>%{</td></tr>", value, "<tr><td></td><td>}%</td></tr>"] |> IO.chardata_to_string()
  end


  defp decorate_with_span(value) when is_bitstring(value) do
    case String.match?(value, ~r/^(http|https):\/\/[^\s]+$/) do
      true -> ~s(<a href='#{value}'>#{value}</a>,)
      false -> ~s(#{value},)
    end
  end

  defp decorate_with_span(value) when is_nil(value), do: nil
  defp decorate_with_span(value) when value == [], do: ~s([],)
  defp decorate_with_span(value), do: ~s(#{value},)

end
