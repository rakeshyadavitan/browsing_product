module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send("find_#{key}", value).limit(25) if value.present?
      end
      results
    end
  end
end