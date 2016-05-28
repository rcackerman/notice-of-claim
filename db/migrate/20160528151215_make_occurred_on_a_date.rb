class MakeOccurredOnADate < ActiveRecord::Migration
  def change
    change_column :screeners, :incident_occurred_on, :date  
  end
end
