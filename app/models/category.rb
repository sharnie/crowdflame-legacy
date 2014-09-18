class Category < ActiveRecord::Base
  has_one  :socialconnetions
  has_many :offers

  validates_presence_of :name
  validates_uniqueness_of :name
end
