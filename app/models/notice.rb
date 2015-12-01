class Notice < ActiveRecord::Base
  belongs_to :screener

  has_many :officers
  has_one :searched_object
  has_one :physical_injury
  has_one :output, inverse_of: :notice
end
