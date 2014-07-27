module TokensHelper
  def filter_title
    state = params[:state].nil? ? "All" : params[:state]
    start_date = params[:start_date].nil? ? DateTime.now : DateTime.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
    "Displaying <u>#{state.capitalize.gsub('_', ' ')}(#{@tokens.size})</u> token(s) on <u>#{start_date.to_date.to_formatted_s(:long)}</u>".html_safe
  end

  def token_state_bgcolor(token)
    if token.completed?
      time_in_seconds = (token.completed_at.to_time - token.created_at.to_time).to_i
    else
      time_in_seconds = (DateTime.now.to_time - token.created_at.to_time).to_i
    end

    if time_in_seconds >= 3600
      "black-bg"
    elsif time_in_seconds >= 60
      minutes = (time_in_seconds/60).to_i
      if minutes <= 30
        "green-bg"
      elsif minutes > 30 && minutes <= 40
        "yellow-bg"
      elsif minutes > 40 && minutes <= 60
        "red-bg"
      elsif minutes > 61
        "black-bg"
      end
    else
      "green-bg"
    end
  end
end
