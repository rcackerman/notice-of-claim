class CreateScreeners < ActiveRecord::Migration
  def up
    create_table :screeners do |t|
      t.boolean   :harmed_mistreated 
      t.datetime :incident_occurred_on
      t.timestamps null: false
    end
  end

  def down
    delete_table :screeners
  end
end
