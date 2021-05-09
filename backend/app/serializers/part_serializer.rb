class PartSerializer < ActiveModel::Serializer

  attributes :id,
             :place,
             :sort,
             :item_code,
             :is_deleted,
             :token,
             :params,
             :impressionist_count

  def impressionist_count
    object.impressionist_count(filter: :session_hash)
  end

  def params
    {}
  end
end
