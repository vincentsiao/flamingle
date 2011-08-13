class AddMissionAttemptStatusIdToMissionAttempts < ActiveRecord::Migration
  def self.up
    add_column :mission_attempts, :mission_attempt_status_id, :integer
  end

  def self.down
    remove_column :mission_attempts, :mission_attempt_status_id
  end
end
