class Part < ApplicationRecord
  def self.item_codes
    self.all.map(&:item_code)
  end
end
