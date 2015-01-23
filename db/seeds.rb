require 'faker'

5.times do
  User.create :username => Faker::Lorem.characters(8), :password => "password"
end

5.times do
  Survey.create :title => Faker::Lorem.characters(8), :author_id => 1
end