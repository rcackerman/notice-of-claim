class CreateSearchedObjects < ActiveRecord::Migration
  def change
    create_table :searched_objects do |so|
      so.belongs_to :notice, index: true
      so.boolean :vehicle
      so.boolean :bag
      so.boolean :pockets
      so.boolean :home
      so.boolean :other
      so.text :other_details

      so.timestamps null: false
    end

    change_table :searched_objects do |so|
      add_foreign_key :searched_objects, :notices
    end
  end
end
