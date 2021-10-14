class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street_address, null: false, default: ''
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :zip, null: false, default: ''
      t.string :country, null: false, default: ''
      t.string :country_code, null: false, default: "+92"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end