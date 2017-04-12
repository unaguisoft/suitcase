class UserDecorator < Draper::Decorator
  delegate_all
  
  def credentials
    user.role.titleize
  end
  
  private

  def user
    object
  end

end

