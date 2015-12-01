class AddNoticeToOfficers < ActiveRecord::Migration
  def change
    add_reference :officers, :notice, index: true
    add_foreign_key :officers, :notices
  end
end
