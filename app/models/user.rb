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

  # generates a reset code with expiration and sends an email to the user.
	def deliver_reset_password_instructions!
		config = sorcery_config
		# hammering protection
		# return false if config.reset_password_time_between_emails.present? && self.send(config.reset_password_email_sent_at_attribute_name) && self.send(config.reset_password_email_sent_at_attribute_name) > config.reset_password_time_between_emails.seconds.ago.utc
		self.class.sorcery_adapter.transaction do
			generate_reset_password_token!
      UserMailer.reset_password_email(self).deliver_now
		end
	end

	def	send_set_password_email!
		self.class.sorcery_adapter.transaction do
			generate_reset_password_token!
      UserMailer.set_password_email(self).deliver_now
		end
	end


end
