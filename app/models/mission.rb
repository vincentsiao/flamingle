class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission_priority
  belongs_to :mission_status
 
  has_many :attempting_users, :through => :mission_attempts, :source => :user
  has_many :mission_attempts do
    
    def new(user)
      create(:user_id => user.id)
      find_by_user_id(user.id).status = "In Progress"
    end

    def abandon(user)
      find_by_user_id(user.id).destroy
    end
    
    def approve(user_id)
      update_all(:mission_attempt_status_id => MissionAttemptStatus.find_by_name("Inactive"))
      find_by_user_id(user_id).status = "Approved"
    end

  end

  def priority
    self.mission_priority.try(:name)
  end

  def status
    self.mission_status.try(:name)
  end
  def status=(name)
    self.mission_status = MissionStatus.find_by_name(name)
    self.save
  end 

  def refresh_status
    if self.mission_attempts.size > 0
      if self.mission_attempts.find_by_mission_attempt_status_id(MissionAttemptStatus.find_by_name("Done"))
        self.status = "Pending Approval"
      else
        self.status = "In Progress"
      end
    else
      self.status = "Available"
    end
    self.save
  end

  def short_description
    if self.description
      if self.description.size > 100
  	    self.description[0 .. 100] + '...'
  	  else 
  	    self.description
  	  end
    end
  end
  
  def human_time
    self.created_at.strftime("%b %d, %Y at %I:%M%p")
  end
end
