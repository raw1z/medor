defmodule Medor.Authenticate do
  @behaviour Plug
  import Plug.Conn
  import Medor.Utils

  require Logger

  def init(options), do: options

  def call(conn, _options) do
    case Enum.find(conn.req_headers, fn {header, _} -> header == "authorization" end) do
      {_, <<"Bearer " :: binary, token :: binary>>} ->
        case validate_token(token) do
          {:ok, payload} ->
            put_private(conn, :medor, payload)

          {:error, message} ->
            Logger.error "[medor] #{message}"
            send_unauthorized(conn)
        end

      nil ->
        Logger.error "[medor] Missing header Authorization"
        send_unauthorized(conn)
    end
  end

  defp validate_token(token) do
    secret = get_config_env(:secret)
    if secret != nil do
      Joken.decode(token, secret)
    else
      {:error, "internal error"}
    end
  end
end

