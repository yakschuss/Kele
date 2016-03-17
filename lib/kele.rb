require "httparty"
require 'json'

class Kele
include HTTParty
    attr_reader :auth_token

  def initialize(email, password)
    response = self.class.post(base_api_endpoint + "sessions", body: {
      email: email,
      password: password
    })

    @auth_token = response["auth_token"]
  end

  def base_api_endpoint
    "https://www.bloc.io/api/v1/"
  end

  def get_me
    response = self.class.get(base_api_endpoint + "users/me", headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
    return body
  end

end
