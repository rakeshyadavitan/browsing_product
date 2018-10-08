class CreateApiTokenDetails < ActiveRecord::Migration
  def change
    create_table :api_token_details do |t|
    	t.integer :app_token_id
      t.string  :api	
      t.timestamps null: false
    end
  end
end
