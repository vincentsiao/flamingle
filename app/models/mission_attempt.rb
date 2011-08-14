class MissionAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission

  def set_status(name)
    self.status = name #MissionAttemptStatus.find_by_name(name)
    self.save
  end
end
