module CategoryScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_category
  end

  private
    def set_category
      if params[:category_id]
        @category = Category.find(params[:category_id])
      end
    end
end

