class AddStatusToCamp < ActiveRecord::Migration[6.1]
  def change
    add_column :camps, :camp_status, :string, default: "inactive"
  end
end
