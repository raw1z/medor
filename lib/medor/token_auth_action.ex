defmodule Medor.TokenAuthAction do
  import Medor.Utils
  require Logger

  def call(conn, {model_module, _}, %{"email" => email, "password" => password}) do
    case  model_module.check_authentication(email, password) do
      {:ok, model} ->
        result = create_token %{
          id: model.id
        }

        case result do
          {:ok, token} ->
            Phoenix.Controller.json conn, %{token: token}

          error ->
            Logger.error "[medor] #{inspect error}"
            send_unauthorized(conn)
        end

      :nok ->
        send_unauthorized(conn)
    end
  end
end
