class AddEmotionalDistresstoNotices < ActiveRecord::Migration
  def change
    add_column :notices, :damages_emotional_distress, :boolean
  end
end
