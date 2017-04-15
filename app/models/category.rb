class Category < ApplicationRecord

  # -- Associations
  has_many :photos, dependent: :destroy

  # -- Validations
  validates :name, presence: true
  validates :dimensions, presence: true
  validates :weight, presence: true
  validates :stock, presence: true
  validates :insurance_percent, presence: true
  
  # -- Scope
end
