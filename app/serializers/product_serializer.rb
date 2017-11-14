class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :reviews
  has_many :tags, through: :taggings
end
