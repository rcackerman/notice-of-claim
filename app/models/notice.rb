class Notice < ActiveRecord::Base
  belongs_to :screener

  has_many :officers
  has_one :searched_object
  has_one :physical_injury
  has_one :output, inverse_of: :notice

  accepts_nested_attributes_for :officers
  accepts_nested_attributes_for :searched_object
  accepts_nested_attributes_for :physical_injury

  validates :name, presence: true
  validates :address, presence: true
  validates :incident_location, presence: true
  validates :incident_occurred_at, presence: true
end
