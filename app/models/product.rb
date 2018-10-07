class Product < ActiveRecord::Base
	include Searchable
	scope :find_model, -> (model) { where("model like ?", "%#{model}%")}
	scope :find_brand, -> (brand) { where("brand like ?", "%#{brand}%")}
	scope :find_ram, -> (ram) { where("ram = ?", ram)}
	scope :find_external_storgae, -> (external_storgae) { where("external_storgae = ?", external_storgae)}
end
