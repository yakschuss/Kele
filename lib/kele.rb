require "httparty"

class Kele
include HTTParty
    attr_reader :auth_token

  def initialize(email, password)
    response = self.class.post(base_api_endpoint + "sessions", values: {
      email: email,
      password: password
    })

    @auth_token = response["auth_token"]
  end

  def base_api_endpoint
    "https://www.bloc.io/api/v1/"
  end

end
