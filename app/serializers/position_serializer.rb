class PositionSerializer < ActiveModel::Serializer
  attributes :latitude, :longitude

  def latitude
    object.latitude.round(4)
  end

  def longitude
    object.longitude.round(4)
  end
end
