class TagSerializer < ActiveModel::Serializer
  attributes :name
  has_many :taggings
end
