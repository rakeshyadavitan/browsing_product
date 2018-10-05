class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :name
    	t.string :model
    	t.string :brand
    	t.integer :year
    	t.integer :ram
    	t.integer :external_storgae    	
      t.timestamps null: false
    end
  end
end
