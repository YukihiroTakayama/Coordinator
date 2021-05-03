class Coordinate < ApplicationRecord
  has_many :parts
  has_many_attached :images

  accepts_nested_attributes_for :parts, allow_destroy: true
end
