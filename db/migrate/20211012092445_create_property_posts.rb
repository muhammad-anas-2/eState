class CreatePropertyPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :property_posts do |t|
      t.text :description, null: false, default: ""
      t.string :size, null: false
      t.string :address
      t.string :city
      t.string :country
      t.integer :market_price
      t.integer :sf_price
      t.integer :property_type
      t.integer :status
      t.integer :facing
      t.date :possession
      t.integer :price_per_sqft , null: false
      t.integer :total_area_sqft, null: false
      t.integer :available_area_sqft
      t.integer :held_tenure


      t.timestamps
    end
  end
end
