class Draper::CollectionDecorator
  delegate :total_pages, :page, :current_page, :limit_value
end
