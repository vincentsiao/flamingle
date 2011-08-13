class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :priority
  has_many :mission_attempts
  has_many :attempting_users, :through => :mission_attempts, :source => :user

  def short_description
    if self.description.size > 100
  	  self.description[0 .. 100] + '...'
  	else 
  	  self.description
  	end
  end
end
