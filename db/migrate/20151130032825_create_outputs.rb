class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.belongs_to :notice
      t.timestamps null: false
    end

    add_foreign_key :outputs, :notices
  end
end
