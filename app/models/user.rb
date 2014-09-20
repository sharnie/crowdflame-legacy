# Future Feature
# Create "star:boolean" column for users table 
# This column will determine whether users have the privilege to change price

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :socialconnections, dependent: :destroy
  has_many :offers, through: :socialconnections
  has_one  :payment, dependent: :destroy

  validates_presence_of   :username
  validates_uniqueness_of :username

  def have_connections?
    self.socialconnections.size > 0 ? true : false
  end

  def incomplete_connections
    incomplete = []
    self.socialconnections.each do |connection|
      errors = {}
      connection.attributes.each do |attribute, value|
        errors[connection.username] ||= {}
        errors[connection.username][attribute] ||= value if value.blank?
      end
      incomplete << errors unless errors[connection.username].blank?
    end
    incomplete
  end

  def self.find_by_profile_name username
    User.find_by(username: username)
  end
end