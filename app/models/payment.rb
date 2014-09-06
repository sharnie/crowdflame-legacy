class Payment < ActiveRecord::Base
  belongs_to :user

  validates :email, presence: true, uniqueness: true
end