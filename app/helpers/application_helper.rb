module ApplicationHelper
  def is_a_modal?
    !!request.xhr?
  end
end
