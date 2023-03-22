# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = FactoryBot.create(:user)

3.times do |index|
  account = FactoryBot.create(:account, {user: user})
  3.times do |index|
    FactoryBot.create(:employee, {account: account, user: user})
  end

  4.times do |index|
    FactoryBot.create(:payment)
  end
end
