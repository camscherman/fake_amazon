class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :vote, source: :user

  has_many :likes, dependent: :destroy

  has_many :likers, through: :likes, source: :user

  validates(:rating,numericality:{
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
  })



  def get_like(user)
    likes.find_by(user: user)
  end

end
