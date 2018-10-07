# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
include Faker

5001.times do
	Product.create(
		name: Faker::Name.name,
		model: Faker::Device.model_name,
		brand: Faker::Device.manufacturer,
		year: Faker::Number.number(4),
		ram: Faker::Number.within(1..10),
		external_storgae: Faker::Number.within(1..100)
	)
end