# frozen_string_literal: true

class DogWalk < ApplicationRecord
  enum status: %i[created accepted canceled started done]
  VALID_DURATIONS = [30, 60].freeze

  after_initialize :set_default_status

  belongs_to :owner
  belongs_to :walker, optional: true
  has_and_belongs_to_many :pets
  belongs_to :starting_position, class_name: 'Position'
  belongs_to :ending_position, class_name: 'Position'
  has_many :route_points

  accepts_nested_attributes_for :starting_position, :ending_position

  validates :duration, presence: true, inclusion: { in: VALID_DURATIONS }
  validates :status, :scheduled_date, :scheduled_start_time, :scheduled_end_time, presence: true
  validate :scheduled_at_future, on: :create

  scope :future_walks, -> { where('scheduled_date > ?', DateTime.now) }

  def scheduled_at_future
    if scheduled_date_time && scheduled_date_time < DateTime.now
      errors.add(:scheduled_date, "can't be in the past")
    end
  end

  def start_walk
    update(start_time: Time.now, status: :started)
  end

  def finish_walk
    update(end_time: Time.now, status: :done)
  end

  def walk_time
    end_time - start_time if done?
  end

  def scheduled_date_time
    if scheduled_date && scheduled_start_time
      (scheduled_date + scheduled_start_time.seconds_since_midnight.seconds).to_datetime
    end
  end

  def update_position(latitude, longitude)
    position = Position.create(latitude: latitude, longitude: longitude)
    route_points.create(position: position)
  end

  private

  def set_default_status
    self.status ||= :created
  end
end
