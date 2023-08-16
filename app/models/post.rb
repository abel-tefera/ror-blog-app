class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_save :update_post_counter

  private

  validates :title, presence: true
  validates :title, length: { in: 1..250 }
  validates :author, presence: true
  validates :comment_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def update_post_counter
    op = User.find_by_id(author.id)
    op.posts_counter = op.posts_counter.to_i + 1
    op.save
  end

  def find_5_comments
    comments.order('created_at desc').limit(5)
  end
end
