class Product < ActiveRecord::Base
	include Searchable
	scope :find_model, -> (model) { where("model ilike ?", "%#{model}%")}
	scope :find_brand, -> (brand) { where("brand ilike ?", "%#{brand}%")}
	scope :find_ram, -> (ram) { where("ram = ?", ram)}
	scope :find_external_storgae, -> (external_storgae) { where("external_storgae = ?", external_storgae)}

	def self.to_excel(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end
