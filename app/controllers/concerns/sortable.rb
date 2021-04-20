module Sortable
  extend ActiveSupport::Concern
  
  included do
    def sort_column(column_to_sort)
      params[:sort] if column_to_sort.column_names.include?(params[:sort])
    end

    def sort_direction
      params[:direction] if %w[asc desc].include?(params[:direction])
    end
  end
end
