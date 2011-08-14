class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attr for authenticating by either username or email
  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :username, :password, 
                  :password_confirmation, :remember_me, :role_id

  has_many :missions, :dependent => :destroy
  has_many :mission_attempts, :dependent => :destroy
  has_many :attempted_missions, :through => :mission_attempts, :source => :mission
  
  has_many :notifications
  belongs_to :role

  def role?(role)
    return self.role.try(:name) == role.to_s
  end
  
  def approval_rate
    pending = self.missions.find_all_by_mission_status_id(MissionStatus.find_by_name("Pending Approval")) 
    completed = self.missions.find_all_by_mission_status_id(MissionStatus.find_by_name("Completed")) 
    if pending.size == 0
      return 100 * !!completed.size
    else
      return 100 * completed.size / (completed.size + pending.size)
    end
  end

  protected

  # Overwrite default Devise methods to use either username or email

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where([
      "lower(username) = :value OR lower(email) = :value", 
      { :value => login.downcase }
    ]).first
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end 

   def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }
    
    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }
    
    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else  
        record = where(attributes).first
      end  
    end  
    
    unless record
      record = new
    
      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end  
    end  
    record
  end
    
  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end
