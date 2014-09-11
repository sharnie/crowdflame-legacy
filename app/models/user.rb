# Future Feature
# Create "star:boolean" column for users table 
# This column will determine whether users have the privilege to change price

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :offers, dependent: :destroy
  has_many :socialconnections, dependent: :destroy
  has_one  :payment, dependent: :destroy

  validates_presence_of :post_code

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
end