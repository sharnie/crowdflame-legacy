class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :socialconnection

  validates_presence_of :title,
                        :price,
                        :delivery,
                        :instructions,
                        :description,
                        :socialconnection_id,
                        :category_id

  validates_length_of    :title, in: 8..70, allow_blank: false
  validates_inclusion_of :delivery, in: 1..5
  validates_inclusion_of :price, in: 5..5
  # validates_length_of :description, :instructions, in: 10..240, allow_blank: false

  default_scope { order('created_at DESC') }

end