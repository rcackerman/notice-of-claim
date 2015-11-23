class Notice < ActiveRecord::Base
  has_many :officers, dependent: destroy
  belongs_to :screener
end
