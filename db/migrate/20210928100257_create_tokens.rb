class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :api_token, null: false
      t.boolean :active, default: true
      t.references :user, foreign_key: true
      t.datetime :expired_at
      t.timestamps
    end
  end
end
