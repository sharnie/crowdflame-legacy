class Offer < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :socialconnection

  validates_presence_of :title,  :price, :delivery, :instructions, :user_id
  validates_length_of :title, in: 8..70, allow_blank: false
  # validates_length_of :description, :instructions, in: 20..240, allow_blank: false
  validates_inclusion_of :price, :delivery, in: 1..5

  default_scope { order('created_at DESC') }

end