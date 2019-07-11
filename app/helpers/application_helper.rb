module ApplicationHelper
  def format_state(state)
    state.slice(0,2).upcase
  end
end
