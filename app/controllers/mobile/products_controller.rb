class Mobile::ProductsController < ApplicationController
	
	skip_before_filter :authenticate_user, :save_login_state
	
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