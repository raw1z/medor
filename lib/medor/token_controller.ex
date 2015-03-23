defmodule Medor.TokenController do
  defmacro __using__(opts) do
    model_info = Medor.Utils.model_info(opts)

    quote do
      def auth(conn, params) do
        Medor.TokenAuthAction.call(conn, unquote(model_info), params)
      end

      def refresh(conn, params) do
        Medor.TokenRefreshAction.call(conn, unquote(model_info), params)
      end
    end
  end
end
