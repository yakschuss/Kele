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
#not working, returning 500 on all requests
  def create_message(subject = nil, body = nil, token = nil)
    data = {
      user_id: student_id,
      recipient_id: student_info("mentor_id"),
      token: token,
      subject: subject,
      "stripped-text" => body
    }
    data.delete_if { |k, v| v.nil? }

    response = self.class.post(base_api_endpoint + "messages", headers: { "authorization" => @auth_token }, body: data)
    body = JSON.parse(response.body)
  end

  def create_submission(branch, commit_link, checkpoint_id, comment)
    data = {
      assignment_branch: branch,
      assignment_commit_link: commit_link,
      checkpoint_id: checkpoint_id,
      comment: comment,
      enrollment_id: student_info("id")
    }
    data.delete_if { |k, v| v.nil? }
    response = self.class.post(base_api_endpoint + "checkpoint_submissions", headers: { "authorization" => @auth_token }, body: data)
    body = JSON.parse(response.body)

  end
private

def student_id
  student_info = self.class.get(base_api_endpoint + "users/me", headers: { "authorization" => @auth_token })
  body = JSON.parse(student_info.body)
  body["id"]
end

end
