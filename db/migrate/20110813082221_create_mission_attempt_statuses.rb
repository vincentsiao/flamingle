class CreateMissionAttemptStatuses < ActiveRecord::Migration
  def self.up
    create_table :mission_attempt_statuses do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :mission_attempt_statuses
  end
end
