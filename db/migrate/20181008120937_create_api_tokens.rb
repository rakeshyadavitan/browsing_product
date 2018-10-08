class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
    	t.string  :device_id
      t.integer :app_version
      t.string  :os_platform
      t.string  :token
      t.string	:username
      t.timestamps null: false
    end
  end
end
