module Roadmap

    def get_roadmap
      id = student_info("roadmap_id")
      response = self.class.get(base_api_endpoint + "roadmaps/#{id}", headers: { "authorization" => @auth_token })
    end

    def get_checkpoint(checkpoint_id)
      response = self.class.get(base_api_endpoint + "checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
      body = JSON.parse(response.body)
    end

    private

    def student_info(attribute)
      student_info = self.class.get(base_api_endpoint + "users/me", headers: { "authorization" => @auth_token })
      body = JSON.parse(student_info.body)
      body["current_enrollment"]["#{attribute}"]
    end

    def base_api_endpoint
      "https://www.bloc.io/api/v1/"
    end
    
end
