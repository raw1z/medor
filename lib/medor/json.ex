defmodule Medor.Json do
  alias Poison, as: JSON
  @behaviour Joken.Json

  def encode(map) do
    JSON.encode!(map)
  end

  def decode(binary) do
    JSON.decode!(binary)
  end
end
