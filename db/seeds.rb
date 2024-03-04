# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faker'

# Створюємо 1000 категорій
1000.times do
  Category.create(
    title: Faker::Commerce.department,
    description: Faker::Lorem.sentence
  )
end

# Створюємо 1000 транзакцій
1000.times do
  Transaction.create(
    title: Faker::Commerce.product_name,
    transaction_type: ['Витрати', 'Дохід'].sample,
    sum: Faker::Number.decimal(l_digits: 2),
    date: Faker::Date.backward(days: 365),
    description: Faker::Lorem.sentence
  )
end
