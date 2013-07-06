# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")

Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
Video.create(title: "Curb Your Enthusiasm", description: "Larry David presents life as himself.", small_cover_url: "/tmp/curbyourenthusiasm_small.jpg", large_cover_url: "/tmp/curbyourenthusiasm_large.jpg", category: comedy)
Video.create(title: "The Shield", description: "Good police show!", small_cover_url: "/tmp/theshield_small.jpg", large_cover_url: "/tmp/theshield_large.jpg", category: drama)
monk = Video.create(title: "Monk", description: "A show about stuff", category: drama)
kevin = User.create(full_name: "Kevin Wang", password: "password", email: "kevin@example.com")

Review.create(user: kevin, video: monk, rating: 4, content: "What a great movie!")
Review.create(user: kevin, video: monk, rating: 1, content: "Not my cup of tea really.")