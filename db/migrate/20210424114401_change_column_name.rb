class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :locations, :location_name, :name
    rename_column :camps, :camp_status, :status
    rename_column :camps, :camp_name, :name
  end
end
