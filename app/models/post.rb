class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  before_save :update_post_counter

  def update_post_counter
    op = User.find_by_id(author.id)
    op.posts_counter = op.posts_counter.to_i + 1
    op.save
  end

  def find_5_comments
    comments.order('created_at desc').limit(5)
  end
end
