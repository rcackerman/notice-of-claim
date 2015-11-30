class UseDifferentPhysicalInjuries < ActiveRecord::Migration
  def change
    remove_column :physical_injuries, :hit
    remove_column :physical_injuries, :kicked
    add_column :physical_injuries, :physical_force, :boolean
    add_column :physical_injuries, :other, :boolean
    add_column :physical_injuries, :other_description, :text
  end
end
