class Coordinate < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_many :parts, dependent: :destroy
  has_many_attached :images

  accepts_nested_attributes_for :parts, allow_destroy: true

  before_create do
    self.token = SecureRandom.hex(16)
  end
end
