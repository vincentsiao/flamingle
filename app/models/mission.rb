class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission_priority
 
  has_many :attempting_users, :through => :mission_attempts, :source => :user
  has_many :mission_attempts do
    
    def new(user)
      create(:user_id => user.id)
      find_by_user_id(user.id).set_status "In Progress"
    end

    def abandon(user)
      find_by_user_id(user.id).destroy
    end
    
    def approve(user_id)
      update_all(:status => "Inactive")#:mission_attempt_status_id => MissionAttemptStatus.find_by_name("Inactive"))
      find_by_user_id(user_id).set_status "Approved"
    end

  end

  after_initialize :init

  def init
    # set default values if nil
    self.active ||= true
  end

  def priority
    self.mission_priority.try(:name)
  end
  
  def status
    if self.mission_attempts.size > 0
      if self.mission_attempts.find_by_status("Done")
        "Pending Approval"
      elsif self.mission_attempts.find_by_status("Approved")
        "Completed"
      else
        "In Progress"
      end
    else
      "Available"
    end 
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
