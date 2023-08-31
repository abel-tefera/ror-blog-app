# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') 
second_user = User.create(name: 'Kim', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Star from hollywood.') 
third_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Mom from somewhere.') 
post_1 = Post.create(title: "HBAR", text: "Hashgraph", author: first_user)
post_2 = Post.create(title: "XRP", text: "The Standard", author: first_user)
post_3 = Post.create(title: "XLM", text: "Stellar", author: second_user)
post_4 = Post.create(title: "ADA", text: "Cardano", author: second_user)

Like.create(author: third_user, post: post_1)
Like.create(author: third_user, post: post_1)
Like.create(author: first_user, post: post_4)

Comment.create(text: "Pump", post: post_1, author: second_user)
Comment.create(text: "Dump", post: post_2, author: second_user)
Comment.create(text: "Ripple", post: post_2, author: third_user)
