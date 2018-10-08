class ProductsController < ApplicationController
	
	skip_before_filter :authenticate_user, :save_login_state
	before_filter :validate_request, :validate_version, :validate_token, :set_header, :validate_login_request

	def index
		debugger
	end

	def validate_request
    if request.headers["device_id"].blank? || request.headers["app_version"].blank? || request.headers["os_platform"].blank? || request.headers["token"].blank?  
      respond_to do |format|
        format.js {render js: {error: 101, message: "Required headers should not be blank. Please make sure to send 'device_id', 'app_version', 'os_platform' and 'token' headers"}.to_json and return}
      end
    end
  end

  def validate_version
    unless ApiToken::VERSIONS.invert.include? request.headers["app_version"]
      respond_to do |format|
        format.js {render js: {error: 2, message: "We do not support app version #{request.headers["app_version"]}."}.to_json and return}
      end
    end
  end

  def validate_token
    unless ApiToken.token_valid?(request.headers["device_id"], ApiToken::VERSIONS.invert[request.headers["app_version"]], request.headers["os_platform"], request.headers["token"], params["username"], params["action"])
      respond_to do |format|
        format.js {render js: {error: 4, message: "Token is invalid/expired"}.to_json and return}
      end
    end
  end

  def validate_login_request
     if request.headers["device_id"].blank? || request.headers["app_version"].blank? || request.headers["os_platform"].blank? || request.headers["token"].blank?  
      respond_to do |format|
        format.js {render js: {error: 101, message: "Required headers should not be blank."}.to_json and return}
      end
    end 
  end

  def set_header
    headers['device_id'] = request.headers["device_id"]
    headers['app_version'] = request.headers["app_version"]
    headers['os_platform'] = request.headers["os_platform"]
    headers['token'] = request.headers["token"]  
  end

end