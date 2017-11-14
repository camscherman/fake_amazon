class User < ApplicationRecord
    has_secure_password

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review

    has_many :votes, dependent: :destroy
    has_many :voted_reviews, through: :vote, source: :review

    has_many :favourites, dependent: :destroy
    has_many :favourite_products, through: :favourites, source: :product

    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true



    def full_name
        "#{first_name} #{last_name}"
    end

    def generate_api_key
        loop do
            self.api_key = SecureRandom.urlsafe_base64(64)
            break unless User.exists?(api_key: self.api_key)
        end
    end
end
