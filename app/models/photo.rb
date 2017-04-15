class Photo < ApplicationRecord

  # -- Misc
  dragonfly_accessor :image

  # -- Associations
  belongs_to :category

  # -- Validations
  validates :category, presence: true
  validates :image_uid, presence: true
  validates :image_name, presence: true
end
