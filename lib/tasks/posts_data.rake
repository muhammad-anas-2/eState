namespace :posts_data do
  desc "add posts contents"

  task add_posts: :environment do
    posts_json = File.open("public/static/posts.json", "rb") { |file| file.read }
    images = ["image-1", "image-2"]
    posts = JSON.parse(posts_json)
    posts.each do |post|
      resource = PropertyPost.new
      resource.description = post["description"]
      resource.size = post["size"]
      resource.address = post["address"]
      resource.city = post["city"]
      resource.country = post["country"]
      resource.market_price = post["market_price"]
      resource.sf_price = post["sf_price"]
      resource.property_type = post["type"]
      resource.status = post["status"]
      resource.facing = post["facing"]
      resource.possession = post["possession"]
      resource.price_per_sqft = post["price_per_sqft"]
      resource.total_area_sqft = post["total_area_sqft"]
      resource.available_area_sqft = post["available_area_sqft"]
      resource.held_tenure = post["held_tenure"]
      resource.possession = Date.today - 4.years
      resource.save!
      images.each do |image|
        resource.visuals.attach(io: File.open(Rails.root.join("app", "assets", "images", "property", "#{image}.jpg")), filename: "#{image}.jpg", content_type: 'image/jpg')
      end
    end
  end

end