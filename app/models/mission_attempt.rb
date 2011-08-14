class MissionAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
  belongs_to :mission_attempt_status

  def status
    self.mission_attempt_status.try(:name)
  end
  def status=(name)
    self.mission_attempt_status = MissionAttemptStatus.find_by_name(name)
    self.save
  end
end
