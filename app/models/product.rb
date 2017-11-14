class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: [:slugged, :history, :finders]
    
    has_many :reviews , dependent: :destroy
    belongs_to :category
    belongs_to :user
    has_many :favourites

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    has_many :fans, through: :favourites, source: :user

    
    validates(:title,{
        presence:true,
        uniqueness: {case_sensitive: false}

    })

    validates(:sale_price,numericality:{
        less_than_or_equal_to: :price
    })

    validate :no_reserved_words

    validates(:price, numericality:{
        greater_than_or_equal_to: 0
    })

    validates(:description,{
        presence: true,
        length: {minimum: 10}
    })

    after_initialize :default_price
    before_validation :capitalize


    scope :search, ->(item) { where(" title ILIKE ? OR description ILIKE ?", "%#{item}%","%#{item}%").order(title: :asc, description: :asc)}

    

    private

    def default_price
        #  self.price ||= 1
        self.sale_price ||= price
     end

    def capitalize
        self.title = title.capitalize if self.title.present?
    end

   def on_sale?
    (sale_price < price)
   end

     def no_reserved_words
        res = ['microsoft', 'apple', 'sony']
        if title.present?
            res.each do |r|
                if title.downcase.include?(r)
                    errors.add(:title, "can't include a reserved word")
                end
            end
        end
    end


end
