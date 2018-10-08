class ApiToken < ActiveRecord::Base

	FIRST_VERSION = 1
  SECOND_VERSION = 2
  THIRD_VERSION = 3
  FOURTH_VERSION = 4
  FIFTH_VERSION = 5

  VERSIONS = {FIRST_VERSION => "0.1", SECOND_VERSION => "1.0", THIRD_VERSION => "1.0.0", FOURTH_VERSION => "1.0.1", FIFTH_VERSION => "1.1.0"}

  def self.token_valid?(device_id, app_version, os_platform, token, username, action)
    
    token_info = ApiToken.find_by_device_id_and_app_version_and_os_platform_and_token_and_username(device_id, app_version, os_platform, token, username)
    if token_info.blank?
      token_details = ApiToken.create("device_id" => device_id, "app_version" => app_version, "os_platform" => os_platform, "token" => token, "username" => username)
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
