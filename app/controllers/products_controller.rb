class ProductsController < ApplicationController
	
	def index
		@product = Product.new		
		@products = Product.search(params.slice(:product).values.first)		
		respond_to do |format|
			format.html
			format.xls { send_data @products.to_excel(col_sep: "\t") }
		end
	end

end
