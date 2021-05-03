class CoordinateSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :user_id
  has_many :images
  has_many :parts
end
