class CreateApiAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_access_tokens do |t|
      t.string :token

      t.timestamps
    end
  end
end
