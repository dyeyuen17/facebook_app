defmodule FacebookAppWeb.Helpers.Plugs.AuthPipeline do
	use Guardian.Plug.Pipeline,
	otp_app: :facebook_app,
	error_handler:  FacebookAppWeb.Helpers.Plugs.ErrorHandler,
	module:  FacebookAppWeb.Helpers.Plugs.Guardian

	plug Guardian.Plug.VerifyHeader
	plug Guardian.Plug.EnsureAuthenticated

end
