module ApplicationHelper
  def active_filter_class(current_filter, filter)
    Rails.logger.debug "Checking active class for #{filter}: #{current_filter == filter}"

    current_filter == filter ? 'filter-active' : ''
  end
end
