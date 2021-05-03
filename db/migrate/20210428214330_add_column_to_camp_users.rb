class AddColumnToCampUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :camp_users, :gender, :string
    add_column :camp_users, :mailing_address, :string
    add_column :camp_users, :social_media_handle, :string
    add_column :camp_users, :emergency_contact, :string
    add_column :camp_users, :side_note, :text
    add_column :camp_users, :camp_activity, :string
    add_column :camp_users, :contribution, :string
    add_column :camp_users, :require_first_aid, :boolean
    add_column :camp_users, :health_condition, :string
    add_column :camp_users, :avail_food_service, :boolean
    add_column :camp_users, :avail_internet_service, :boolean
    add_column :camp_users, :progress, :integer, default: 0
  end
end
