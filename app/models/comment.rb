class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  before_save :update_comments_counter

  def update_comments_counter
    post = Post.find_by_id(post_id)
    post.comments_counter = post.comments_counter.to_i + 1
    post.save
  end
end
