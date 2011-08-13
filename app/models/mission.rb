class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :priority
  has_many :mission_attempts
end
