# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Favourite.destroy_all

Product.destroy_all
Category.destroy_all
User.destroy_all
Tag.destroy_all

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

20.times do
    Tag.create(name: Faker::HitchhikersGuideToTheGalaxy.planet)
end

tags = Tag.all
products = Product.all

products.each do |p|
    rand(1..5).times.each do
        Review.create(body: Faker::RickAndMorty.quote, 
                        rating:rand(1..5),
                        product: p,
                        user: users.sample )
    end

    p.tags = tags.shuffle.slice(0..rand(8))
end
reviews = Review.all
taggings = Tagging.all
puts "#{Product.all.count} products created"


puts Cowsay.say("Created #{products.count} products", :ghostbusters)
puts Cowsay.say("Created #{reviews.count} reviews", :moose)
puts Cowsay.say("Created #{users.count} users", :tux)
puts Cowsay.say("#{tags.count} tags created", :moose)
puts Cowsay.say("#{taggings.count} taggings", :sheep)
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"