class Mobile::ProductsController < ApplicationController
	
	skip_before_filter :authenticate_user, :save_login_state
  before_filter :validate_request, :validate_token
	
  def index    
    @response = {}
    @response["header"] = {'username' => params["username"]}
    @response["payload"] = []
    parameter = {}
    parameter["model"] = params[:model]
    parameter["brand"] = params[:brand]
    parameter["ram"] = params[:ram]
    parameter["external_storgae"] = params[:extrenal_storage]
    @products = Product.search(parameter)
    @products.each do |product|
      api_hash = {}
      api_hash["id"] = product.id
      api_hash["name"] = product.name
      api_hash["model"] = product.model
      api_hash["brand"] = product.brand
      api_hash["year"] = product.year
      api_hash["ram"] = product.ram
      api_hash["external_storgae"] = product.external_storgae
      @response["payload"] << api_hash     
    end
    respond_to do |format|
      format.js {render js: @response.to_json}
    end
  end

  private

  def validate_request
    if params["username"].blank?
      respond_to do |format|
        format.js {render js: {error: 101, message: "Username should not be blank."}.to_json and return}
      end
    else
      user = User.find_by_username(params["username"])
      unless user.present?
        respond_to do |format|
          format.js {render js: {error: 101, message: "You are not authorized to access."}.to_json and return}
        end
      end
    end
  end

  def validate_token
    if request.headers["token"].blank?
      respond_to do |format|
        format.js {render js: {error: 101, message: "Required headers should not be blank. Please make sure to send 'token' header."}.to_json and return}
      end
    else
      unless ApiToken.token_valid?(request.headers["token"], params["username"], params["action"])
        respond_to do |format|
          format.js {render js: {error: 101, message: "Token is invalid/expired"}.to_json and return}
        end
      end
    end
  end

end