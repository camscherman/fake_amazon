FactoryGirl.define do
  factory :product do
    association :user, factory: :user
    sequence(:title) {|n| "#{Faker::Commerce.product_name} -- #{n}"}
    description "#{Faker::Lorem.paragraph}"
    price 50
    sale_price 30


  end
end
