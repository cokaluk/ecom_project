# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Product.destroy_all
Category.destroy_all
Province.destroy_all
AdminUser.destroy_all

4.times do
  category = Category.create(name: Faker::Commerce.department)
  25.times do
    Product.create(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 0..100.0),
      stock: Faker::Number.between(from: 1, to: 100),
      description: Faker::Lorem.sentence(word_count: 12),
      category: category
    )
  end
end

Province.create([ {name: "Alberta"},
                  {name: "British Columbia"},
                  {name: "Manitoba"},
                  {name: "New Brunswick"},
                  {name: "Newfoundland and Labrador"},
                  {name: "Nova Scotia"},
                  {name: "Ontario"},
                  {name: "Prince Edward Island"},
                  {name: "Quebec"},
                  {name: "Saskatchewan"},
                  {name: "Yukon"},
                  {name: "Nunavut"},
                  {name: "Northwest Territories"}
                ])

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?