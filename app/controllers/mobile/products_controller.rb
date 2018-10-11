class Mobile::ProductsController < ApplicationController
	
	skip_before_filter :authenticate_user, :save_login_state
  before_filter :validate_request

  def validate_request
    if params["username"].blank?
      respond_to do |format|
        format.js {render js: {error: 101, message: "Username should not be blank."}.to_json and return}
      end
    else
      @user = User.find_by_username(params["username"])
      if @user.present?
        unless ApiToken.token_valid?(request.headers["token"], params["username"], params["action"])
          respond_to do |format|
            format.js {render js: {error: 102, message: "Token is invalid/expired"}.to_json and return}
          end
        end
      else
        respond_to do |format|
          format.js {render js: {error: 103, message: "You are not authorized to access."}.to_json and return}
        end
      end
    end
  end
	
  def index    
    @response = {}
    @response["header"] = {'username' => params["username"]}
    @response["payload"] = []
    parameter = {}
    parameter["model"] = params[:model]
    parameter["band"] = params[:band]
    parameter["ram"] = params[:ram]
    parameter["external_storage"] = params[:external_storage]
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

end