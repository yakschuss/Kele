require "httparty"
require 'json'
require 'roadmap'

class Kele
include HTTParty
include Roadmap

    attr_reader :auth_token

  def initialize(email, password)
    response = self.class.post(base_api_endpoint + "sessions", body: {
      email: email,
      password: password
    })

    @auth_token = response["auth_token"]
  end


  def get_me
    response = self.class.get(base_api_endpoint + "users/me", headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
    return body
  end

  def get_mentor_availability
    id = student_info("mentor_id")
    response = self.class.get(base_api_endpoint + "mentors/#{id}/student_availability", headers: { "authorization" => @auth_token })
  end


end
