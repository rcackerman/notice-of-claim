class CreatePhysicalInjuries < ActiveRecord::Migration
  def change
    create_table :physical_injuries do |pi|
      pi.belongs_to :notice, index: true
      pi.boolean :hit
      pi.boolean :kicked
      pi.boolean :beaten_with_object
      pi.boolean :choked
      pi.boolean :pepper_sprayed
      pi.boolean :tasered
      pi.boolean :attacked_by_police_animal
      pi.boolean :hit_by_police_vehicle
      pi.boolean :handcuffs_too_tight
      pi.timestamps null: false
    end

    change_table :physical_injuries do |pi|
      add_foreign_key :physical_injuries, :notices
    end
  end
end
