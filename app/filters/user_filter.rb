class UserFilter

  include ActiveModel::Model
  
  attr_accessor :term, :current_user_id

  def call
    users = User.all
    users = users.where('name ILIKE :term OR email ILIKE :term', term: "%#{@term}%") if @term.present?
    
    users
  end

end
