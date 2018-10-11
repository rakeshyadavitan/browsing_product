class ApiToken < ActiveRecord::Base

  def self.token_valid?(token, username, action)
    token_info = ApiToken.find_by_token_and_username(token, username)
    if token_info.blank?
      token_details = ApiToken.create("token" => token, "username" => username)
      ApiTokenDetail.create("app_token_id" => token_details.id, "api" => action)
      return true
    else
      if (Time.now - token_info.updated_at) / 3600 > 1
        return false
      else
        token_info.touch
        ApiTokenDetail.create("app_token_id" => token_info.id, "api" => action)
        return true
      end
    end
  end
end
