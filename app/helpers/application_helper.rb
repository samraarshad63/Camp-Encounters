module ApplicationHelper
  include Pagy::Frontend
  
  def sortable(column, temp, title = nil)
    title ||= column.titleize
    css_class = "current #{sort_direction}" if column == sort_column(temp)
    direction = 
      if column == sort_column(temp) && sort_direction == 'desc'
        'asc'
      else
        'desc'
      end
    link_to title, { sort: column, direction: direction, keyword: params[:keyword] }, { class: 'text-black' }
  end
end
