  # This file should ensure the existence of records required to run the application in every environment (production,
  # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
  # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
  #
  # Example:
  #
  #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
  #     MovieGenre.find_or_create_by!(name: genre_name)
  #   end
  #
  facilities = [
  "Free parking",
  "Free Wi-Fi",
  "Swimming pool",
  "Gym",
  "Spa"
]

activities = [
  "Surfing",
  "Skiing",
  "Beachfront",
  "Romantic",
  "Family-friendly"
]

popular_filters = [
  "Family-friendly",
  "Romantic",
  "Beachfront",
  "Skiing",
  "Surfing"
]

properties = [
  {
    name: "Soneva Fushi",
    address: "Kunfunadhoo Island, Baa Atoll, Maldives",
    tagline: "Luxurious barefoot living in paradise",
    short_description: "Discover this magical private island resort with pristine beaches, crystal clear waters and unparalleled luxury villa accommodations.",
    latitude: 5.1176,
    longitude: 73.0627,
    normal_price: 2500,
    discounted_price: 2000,
    discount_percent: 20,
    current_price: 2000
  },
  {
    name: "Velaa Private Island",
    address: "Noonu Atoll, Maldives",
    tagline: "Beyond luxury, beyond imagination",
    short_description: "An ultra-luxury private island resort with world-class amenities including private pools, spa and gourmet dining.",
    latitude: 5.9880,
    longitude: 73.3773,
    normal_price: 3000,
    discounted_price: 2400,
    discount_percent: 20,
    current_price: 2400
  },
  {
    name: "One&Only Reethi Rah",
    address: "North Malé Atoll, Maldives",
    tagline: "An exclusive island sanctuary",
    short_description: "Set on one of the largest islands in North Malé Atoll, this stunning resort offers beach and water villas with exceptional privacy.",
    latitude: 4.5148,
    longitude: 73.3579,
    normal_price: 2800,
    discounted_price: 2240,
    discount_percent: 20,
    current_price: 2240
  },
  {
    name: "Cheval Blanc Randheli",
    address: "Noonu Atoll, Maldives",
    tagline: "Contemporary luxury in paradise",
    short_description: "A luxury resort offering elegant villas, fine dining, and a Guerlain spa in a stunning tropical setting.",
    latitude: 5.9754,
    longitude: 73.4692,
    normal_price: 3500,
    discounted_price: 2800,
    discount_percent: 20,
    current_price: 2800
  },
  {
    name: "Gili Lankanfushi",
    address: "Lankanfushi Island, North Malé Atoll, Maldives",
    tagline: "Eco-luxury at its finest",
    short_description: "An eco-resort featuring overwater villas, sustainable practices, and exceptional service in a pristine environment.",
    latitude: 4.2859,
    longitude: 73.5516,
    normal_price: 2200,
    discounted_price: 1760,
    discount_percent: 20,
    current_price: 1760
  },
  {
    name: "JOALI Maldives",
    address: "Muravandhoo Island, Raa Atoll, Maldives",
    tagline: "The joy of living",
    short_description: "An immersive art and luxury resort featuring unique accommodations and experiential dining concepts.",
    latitude: 5.9018,
    longitude: 73.3579,
    normal_price: 2900,
    discounted_price: 2320,
    discount_percent: 20,
    current_price: 2320
  },
  {
    name: "Waldorf Astoria Maldives Ithaafushi",
    address: "Ithaafushi Island, South Malé Atoll, Maldives",
    tagline: "Unforgettable luxury awaits",
    short_description: "A tropical paradise featuring private pools, world-class dining, and exceptional wellness facilities.",
    latitude: 4.0259,
    longitude: 73.4692,
    normal_price: 3200,
    discounted_price: 2560,
    discount_percent: 20,
    current_price: 2560
  },
  {
    name: "Raffles Maldives Meradhoo",
    address: "Meradhoo Island, Gaafu Alifu Atoll, Maldives",
    tagline: "Where luxury meets marine wonder",
    short_description: "An oasis of luxury offering butler service, marine butlers, and exceptional overwater and beach villas.",
    latitude: -0.6324,
    longitude: 73.1467,
    normal_price: 2600,
    discounted_price: 2080,
    discount_percent: 20,
    current_price: 2080
  },
  {
    name: "The St. Regis Maldives Vommuli Resort",
    address: "Vommuli Island, Dhaalu Atoll, Maldives",
    tagline: "Visionary architectural design",
    short_description: "A sophisticated resort featuring distinctive architecture, signature butler service, and exquisite dining options.",
    latitude: 2.6924,
    longitude: 72.9568,
    normal_price: 2700,
    discounted_price: 2160,
    discount_percent: 20,
    current_price: 2160
  },
  {
    name: "Patina Maldives",
    address: "Fari Islands, North Malé Atoll, Maldives",
    tagline: "Where nature meets design",
    short_description: "A modern resort emphasizing sustainability, art, and wellness in a stunning archipelago setting.",
    latitude: 4.4259,
    longitude: 73.7159,
    normal_price: 2400,
    discounted_price: 1920,
    discount_percent: 20,
    current_price: 1920
  }
]

facilities.each do |facility|
  Facility.find_or_create_by(name: facility)
end

activities.each do |activity|
  Activity.find_or_create_by(name: activity)
end

popular_filters.each do |filter|
  PopularFilter.find_or_create_by(name: filter)
end

properties.each do |property|
  p = Property.create(property)
  p.facilities << Facility.all.sample(3)
  p.activities << Activity.all.sample(3)
  p.popular_filters << PopularFilter.all.sample(3)
end

# Create default tags
default_tags = ["Travel", "Maldives", "Holiday", "Beach", "Luxury", "Vacation", "Islands", "Resort", "Spa", "Adventure"]

default_tags.each do |tag_name|
  Tag.find_or_create_by(name: tag_name)
end

puts "Default tags created!"

# Create admin user
Admin.find_or_create_by!(email: 'admin@maldivesbeachvacation.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
end

puts "Admin user created!"
