defmodule Medor.TokenRefreshAction do
  import Medor.Utils
  require Logger

  def call(conn, _model_info, %{"token" => token}) do
    case refresh_token(token) do
      {:ok, refreshed_token} ->
        Phoenix.Controller.json conn, refreshed_token, %{token: token}
      error ->
        Logger.error "[medor] #{inspect error}"
        send_unauthorized(conn)
    end
  end
end
