class AddScreenerToNotice < ActiveRecord::Migration
  def change
    add_reference :notices, :screener, index: true
    add_foreign_key :notices, :screeners
  end
end
