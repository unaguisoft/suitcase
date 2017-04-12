class User < ApplicationRecord
  authenticates_with_sorcery!

  ROLES = %w(admin normal)
  
  # -- Misc
  enum role: { admin: 0, normal: 1 }

  # -- Scopes
  scope :by_name, -> { order(:name) }
  scope :but, -> (id) { where.not(id: id) } 

  # -- Associations

  # -- Validations
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :role, inclusion: {in: ROLES}

  # Check if user has role
  def is?(a_role)
    (Array(a_role).collect(&:to_sym) & [self.role.to_sym]).any?
  end

end
