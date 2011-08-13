class AddMissionStatusIdToMissions < ActiveRecord::Migration
  def self.up
    add_column :missions, :mission_status_id, :integer
  end

  def self.down
    remove_column :missions, :mission_status_id
  end
end
