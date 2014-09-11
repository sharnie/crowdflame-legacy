# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Advertising", "Beauty", "Business", "Celebrity", "DIY / Craft", "Entertainment", "Family", "Fashion", "Food", "General", "Health", "Lifestyle", "Music", "News", "Pop Culture", "Social Media", "Sports", "Technology", "Travel", "Video Games"].each do |category|
  Category.create(name: category)
end