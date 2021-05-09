class CoordinateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :title,
             :caption,
             :user_id,
             :images,
             :parts,
             :is_published,
             :is_deleted,
             :impressionist_count

  has_many :parts

  def images
    object.images.map { |image| url_for(image) }
  end

  def impressionist_count
    object.impressionist_count(filter: :session_hash)
  end
end
