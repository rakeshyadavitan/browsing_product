module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(filtering_params)
      results = self.where(nil)
      # if filtering_params.present?
        filtering_params.each do |key, value|
          results = results.public_send("find_#{key}", value).limit(25) if value.present?
        end
      # end
      results
    end
  end
end