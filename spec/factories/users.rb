require 'faker'

FactoryGirl.define do

  factory :user do | f |
    f.name { Faker::Company.name }
    f.email {Faker::Internet.email }
    f.password { Faker::Internet.password(6, 20) }
  end

end
