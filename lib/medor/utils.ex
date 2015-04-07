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

  def create_token(payload) do
    secret = get_config_env(:secret)
    claims = %{
      "iss": "medor",
      "exp": token_expiry_date_from_now
    }

    Joken.Token.encode(secret, Medor.Json, payload, :HS256, claims)
  end

  def refresh_token(token) do
    secret = get_config_env(:secret)
    case Joken.Token.decode(secret, Medor.Json, token, :HS256) do
      {:ok, decoded_payload} ->
        refreshed_payload = decoded_payload
        |> Map.delete("exp")
        |> Map.delete("iss")

        create_token(refreshed_payload)

      error ->
        error
    end
  end

  def validate_token(token) do
    secret = get_config_env(:secret)
    if secret != nil do
      Joken.Token.decode(secret, Medor.Json, token, :HS256)
    else
      {:error, "internal error"}
    end
  end

  defp token_expiry_date_from_now() do
    Date.convert(Date.shift(Date.now, secs: 36000), :secs)
  end
end
