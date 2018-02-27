defmodule FacebookAppWeb.Helpers.Plugs.CurrentUser do
	@behaviour Plug
	import Plug.Conn

	def init(opts) do
		opts
	end

	def call(conn, _) do
		with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
			{:ok, user} = authorize(token)
			assign(conn, :current_user, user)
		end
	end

	def authorize(token) do
		{:ok, claims} = FacebookAppWeb.Helpers.Plugs.Guardian.decode_and_verify(token)
		{:ok, resource} = FacebookAppWeb.Helpers.Plugs.Guardian.resource_from_claims(claims)

		{:ok, resource}
	end
end
