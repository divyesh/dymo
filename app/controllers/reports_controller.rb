class ReportsController < ApplicationController
  def index
    from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

    @tokens = Token.where("(created_at >= ? AND created_at <= ?) AND (state = ?)", from_date, to_date, "completed")

    if params[:duration] == "30"
      @tokens.to_a.select! { |t| (t.completed_at - t.created_at) <= 1800 }
    elsif params[:duration] == "40"
      @tokens.to_a.select! { |t| (((t.completed_at - t.created_at) > 1800) && ((t.completed_at - t.created_at) <= 2400)) }
    elsif params[:duration] == "60"
      @tokens.to_a.select! { |t| (((t.completed_at - t.created_at) > 2400) && ((t.completed_at - t.created_at) <= 3600)) }
    elsif params[:duration] == "61"
      @tokens.to_a.select! { |t| (t.completed_at - t.created_at) > 3600 }
    end

    respond_to do |format|
        format.html
        format.csv { send_data @tokens.to_csv }
        format.xls
      end
  end

  private
    def formatted_date(date, options)
      time = options[:time]
      time = (options[:type] == 'start_time' ? DateTime.now.beginning_of_day.strftime("%H:%M") : DateTime.now.end_of_day.strftime("%H:%M")) if time.blank?
      date = Date.today.to_s if params[:start_date].blank?
      (time + ' ' + date).to_datetime
    end
end
