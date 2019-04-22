class DogWalkSerializer < ActiveModel::Serializer
  attributes :id, :status, :price, :duration, :scheduled_date, :scheduled_start_time, :scheduled_end_time, :walk_time, :created_at
  
  has_many :pets
  belongs_to :walker
  belongs_to :starting_position
  belongs_to :ending_position

  def scheduled_start_time
    object.scheduled_start_time.to_s(:time)
  end

  def scheduled_end_time
    object.scheduled_end_time.to_s(:time)
  end
end
