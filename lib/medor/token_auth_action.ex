defmodule Medor.TokenAuthAction do
  import Medor.Utils
  alias Timex.Date

  def call(conn, {model_module, _}=model_info, %{"email" => email, "password" => password}) do
    case  model_module.check_authentication(email, password) do
      {:ok, model} ->
        Phoenix.Controller.json conn, build_resp(model, model_info)

      :nok ->
        send_unauthorized(conn)
    end
  end

  defp build_resp(model, {model_module, model_name}) do
    %{}
    |> Map.put(model_name, model.id)
    |> Map.put(:token, create_token(%{email: model.email, admin: model.admin, blocked: model.blocked}))
  end

  defp create_token(payload, claims \\ %{}) do
    secret = Medor.Utils.get_config_env(:secret)
    effective_claims = Map.merge %{
      "iss": "medor",
      "exp": Date.convert(Date.shift(Date.now, secs: 14400), :secs)
    }, claims
    {:ok, token} = Joken.encode(payload, secret, :HS256, effective_claims)
    token
  end
end
