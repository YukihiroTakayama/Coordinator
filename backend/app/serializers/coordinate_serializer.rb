class CoordinateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :caption, :user_id, :images
  has_many :parts

  def images
    object.images.map { |image| url_for(image) }
  end
end
