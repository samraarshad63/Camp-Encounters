class AddColumnToCampUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :camp_users, :gender, :string
    add_column :camp_users, :mailing_address, :string
    add_column :camp_users, :social_media_handle, :string, default: 'none'
    add_column :camp_users, :emergency_contact, :string
    add_column :camp_users, :side_note, :text
    add_column :camp_users, :camp_activity, :string, default: 'none'
    add_column :camp_users, :contribution, :string
    add_column :camp_users, :require_first_aid, :boolean, default: 'false'
    add_column :camp_users, :health_condition, :string, default: 'none'
    add_column :camp_users, :avail_food_service, :boolean, default: 'false'
    add_column :camp_users, :avail_internet_service, :boolean, default: 'false'
  end
end
