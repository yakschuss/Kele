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

  def get_messages(arg = nil)
    if arg.nil? #if no page number specified - get total number of messages
      response = self.class.get(base_api_endpoint + "message_threads", headers: { "authorization" => @auth_token })
      #make as many requests as there are pages, +1 to round up
      pages = (1..(response["count"]/10 + 1)).map do |n|
             self.class.get(base_api_endpoint + "message_threads", body: { page: n }, headers: { "authorization" => @auth_token })
          end
      pages
    else
      response = self.class.get(base_api_endpoint + "message_threads", body: { page: arg }, headers: { "authorization" => @auth_token })
      body = JSON.parse(response.body)
    end

  end

end
