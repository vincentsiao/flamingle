class CreateMissionAttempts < ActiveRecord::Migration
  def self.up
    create_table :mission_attempts do |t|
      t.integer :user_id
      t.integer :mission_id
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :mission_attempts
  end
end
