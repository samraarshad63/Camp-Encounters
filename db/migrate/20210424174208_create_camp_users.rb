class CreateCampUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :camp
      t.timestamps
    end
  end
end
