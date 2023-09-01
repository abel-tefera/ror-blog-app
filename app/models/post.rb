class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  validates :title, presence: true
  validates :title, length: { in: 1..250 }
  validates :author, presence: true
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  after_save :update_post_counter
  before_destroy -> { User.find_by(id: author.id).decrement!(:posts_counter) }

  def find_5_comments
    comments.order('created_at desc').limit(5)
  end

  private

  def update_post_counter
    op = User.find_by_id(author.id)
    op.posts_counter = op.posts_counter.to_i + 1
    op.save
  end
end
