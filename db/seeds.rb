# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "💸 Seeding transactions..."
Transaction.create!([
    { payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z" },
    { payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z" },
    # Exercise prompt was not clear as to why line 15 would be a valid input.
    # To use it, uncommment line 15 and comment out line 5 in 'transaction.rb' 
    # in the 'models' folder when running `rails db:seed` or `rails db:reset`. 
    # { payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z" },
    { payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z" },
    { payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z" }
])

puts "💸 Done seeding!"