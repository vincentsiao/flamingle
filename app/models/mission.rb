class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :priority
  has_many :mission_attempts
  has_many :attempting_users, :through => :mission_attempts, :source => :user
end
