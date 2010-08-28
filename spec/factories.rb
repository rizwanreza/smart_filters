Factory.define :address_book do |a|
  a.name Faker::Name.name
  a.address "#{Faker::Address.street_address}\n#{Faker::Address.city} #{Faker::Address.us_state} #{Faker::Address.zip_code}\nUSA"
  a.company Faker::Company.name
  a.email Faker::Internet.email
  a.zipcode Faker::Address.zip_code
  a.phone Faker::PhoneNumber.phone_number
  a.domain Faker::Internet.domain_name
end