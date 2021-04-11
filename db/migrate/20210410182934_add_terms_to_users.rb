class AddTermsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :terms, :boolean
  end
end
