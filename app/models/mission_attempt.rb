class MissionAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
  belongs_to :mission_attempt_status
end
