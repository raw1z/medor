defmodule Medor.Utils do
  alias Timex.Date
  import Plug.Conn

  def get_config_env(key, default_value \\ nil) do
    Application.get_env(:medor, key, default_value)
  end

  def send_unauthorized(conn) do
    conn
    |> put_resp_header("cache-control", "no-cache")
    |> put_resp_header("content-length", "0")
    |> send_resp(401, "")
    |> halt
  end

  def model_info(opts) do
    {model_module, _} = opts
    |> Keyword.get(:model)
    |> Code.eval_quoted

    model_name = "#{model_module}"
    |> String.split(".")
    |> List.last
    |> Inflex.parameterize("_")

    {model_module, model_name}
  end
end
