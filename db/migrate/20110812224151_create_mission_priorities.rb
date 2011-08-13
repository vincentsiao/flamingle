class CreateMissionPriorities < ActiveRecord::Migration
  def self.up
    create_table :mission_priorities do |t|
      t.string :name
      t.integer :cost
      t.integer :value

#      t.timestamps
    end
  end

  def self.down
    drop_table :mission_priorities
  end
end
