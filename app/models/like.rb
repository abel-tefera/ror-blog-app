class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_likes

  private 

  def update_likes
    post.increment!(:likes_counter)
  end
end
