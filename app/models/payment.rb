class Payment < ActiveRecord::Base
  belongs_to :user

  validates :email, presence: true, uniqueness: true
  validates_uniqueness_of :email
end
