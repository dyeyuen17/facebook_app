defmodule FacebookAppWeb.Helpers.Plugs.ErrorHandler do
	import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Poison.encode!(%{message: "Unauthorized"})
		send_resp(conn, 401, body)
  end
end
