# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Create an admin user for demo purposes
User.create(first_name: "Johnny", last_name: "Depp", email: "johnny.depp@test.com", password: "password123", role: "admin")

