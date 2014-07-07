module TokensHelper
  def filter_title
    state = params[:state].nil? ? "All" : params[:state]
    start_date = params[:start_date].nil? ? DateTime.now : DateTime.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
    "Displaying <u>#{state.capitalize.gsub('_', ' ')}(#{@tokens.size})</u> token(s) on <u>#{start_date.to_date.to_formatted_s(:long)}</u>".html_safe
  end
end
