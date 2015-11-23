class CreateOfficers < ActiveRecord::Migration
  def change
    create_table :officers do |t|
      t.string   :name
      t.string   :badge_number
      t.timestamps null: false
    end
  end
end
