class AddActorIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :actor_id, :integer
    add_column :users, :actor_type, :string
  end
end
