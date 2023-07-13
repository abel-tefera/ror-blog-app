class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  before_save :update_post_counter

  scope :get_5_comments, ->(post) { post.comments.order('created_at DESC').limit(5) }

  def update_post_counter
    op = User.find_by_id(author.id)
    op.posts_counter = op.posts_counter.to_i + 1
    op.save
  end
end
