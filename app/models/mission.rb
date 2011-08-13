class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :priority
  has_many :mission_attempts

  def short_description
    if self.description.size > 100
  	  self.description[0 .. 100] + '...'
  	else 
  	  self.description
  	end
  end
end
