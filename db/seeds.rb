# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if User.with_deleted.count.zero?
  User.create_with(full_name: 'Alice', password: 'alicepassword', confirmed_at: Time.now).find_or_create_by!(email: 'alice@example.com')
  User.create_with(full_name: 'Bob', password: 'bobpassword', confirmed_at: Time.now).find_or_create_by!(email: 'bob@example.com')
  User.create_with(full_name: 'Carl', password: 'carlpassword', confirmed_at: Time.now).find_or_create_by!(email: 'carl@example.com')
end
