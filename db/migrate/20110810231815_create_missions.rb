class CreateMissions < ActiveRecord::Migration
  def self.up
    create_table :missions do |t|
      t.string :title
      t.string :description
      t.string :priority
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :missions
  end
end
