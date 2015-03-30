class AddTimestampsToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :created_at, :timestamp
    add_column :memberships, :updated_at, :timestamp
  end
end
