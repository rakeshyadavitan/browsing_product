class ProductsController < ApplicationController
	
	def index
		@product = Product.new		
		@products = Product.search(params.slice(:product).values.first)		
		respond_to do |format|
			format.html
		end
	end

end
