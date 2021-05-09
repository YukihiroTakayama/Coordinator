class Part < ApplicationRecord
  is_impressionable

  belongs_to :coordinate
  default_scope { where(is_deleted: false).order(:sort) }

  before_create do
    max_sort = Part.where(coordinate_id: coordinate.id).maximum(:sort).to_i
    self.sort = max_sort + 1
    self.token = SecureRandom.hex(16)
  end

  def self.item_codes
    self.all.map(&:item_code)
  end
end
