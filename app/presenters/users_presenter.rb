class UsersPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def users
    @users ||= filter.call.page(@params[:page]).decorate
  end
  
  def filter
    @filter ||= UserFilter.new(filter_params)
  end

  private
  
    def filter_params
      if @params[:user_filter]
        parameters = @params.require(:user_filter).permit(:term, :current_user_id)
      end

      parameters || {}
    end

end
