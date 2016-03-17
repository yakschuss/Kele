require "kele/version"
require "httparty"

class Kele

    attr_reader :auth_token

  def initialize(username, password)
    response = HTTParty.post(base_api_endpoint + "/sessions", {
      username: username,
      password: password
    })

    @auth_token = response["auth_token"]

  end

  def base_api_endpoint
    "https://www.bloc.io/api/v1"
  end
end
