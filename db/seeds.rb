# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
Category.destroy_all
User.destroy_all

PASSWORD = "supersecret"
super_user = User.create(
    first_name: 'Jon',
    last_name: 'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD
)
10.times.each do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
        password: PASSWORD
    )
end
users = User.all

8.times.each do
    Category.create(name: Faker::Commerce.department)
end

@categories = Category.all


1000.times.each do
    q = Product.create(title: Faker::Commerce.product_name, description: Faker::Hipster.sentence, price: rand(1...50000), category: @categories.sample, user: users.sample)
    if q.errors.present?
        q.errors.full_messages
    end
end

products = Product.all

products.each do |p|
    rand(1..5).times.each do
        Review.create(body: Faker::RickAndMorty.quote, 
                        rating:rand(1..5),
                        product: p,
                        user: users.sample )
    end
end
reviews = Review.all
puts "#{Product.all.count} products created"


puts Cowsay.say("Created #{products.count} products", :ghostbusters)
puts Cowsay.say("Created #{reviews.count} reviews", :moose)
puts Cowsay.say("Created #{users.count} users", :tux)
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"