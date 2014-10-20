class ReportsController < ApplicationController
  def index
    from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

    @tokens = current_location.tokens.where("(created_at >= ? AND created_at <= ?) AND (state = ?)", from_date, to_date, "completed")

    if params[:duration] == "30"
      @tokens.to_a.select! { |t| (t.completed_at - t.created_at) <= 1800 }
    elsif params[:duration] == "40"
      @tokens.to_a.select! { |t| (((t.completed_at - t.created_at) > 1800) && ((t.completed_at - t.created_at) <= 2400)) }
    elsif params[:duration] == "60"
      @tokens.to_a.select! { |t| (((t.completed_at - t.created_at) > 2400) && ((t.completed_at - t.created_at) <= 3600)) }
    elsif params[:duration] == "61"
      @tokens.to_a.select! { |t| (t.completed_at - t.created_at) > 3600 }
    end

    pie_chart_tokens

    respond_to do |format|
      format.html
      format.csv { send_data @tokens.to_csv }
      format.xls
    end
  end

  def physician_patients
    unless params[:filter_physician_id].blank?
      @physician = Physician.find(params[:filter_physician_id])

      if params[:all_patients] == 'yes'
        @visits = @physician.visits.where("visits.location_id = ?", current_location)
      else
        from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
        to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

        @visits = @physician.visits.where("(physician_visits.created_at >= ? AND physician_visits.created_at <= ? AND location_id = ?)", from_date, to_date, current_location)
      end
    else
      flash[:alert] = "Please select physician."
      @visits = []
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = PhysicianPatientsPdf.new(@physician, @visits)
        send_data pdf.render, filename: "#{@physician.physician_full_name}",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def test_statistic
    params[:group_by] ||= "by_physician"

    @from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    @to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

    if params[:group_by] == "by_physician"
      @physicians = Physician.joins(:visits).where("(visits.created_at >= ? AND visits.created_at <= ?) AND visits.location_id = ?", @from_date, @to_date, current_location).distinct
    else
       @visit_tests = VisitTest.joins(:visit).where("visit_tests.created_at >= ? AND visit_tests.created_at <= ? AND visits.location_id = ?", @from_date, @to_date, current_location).select("visit_tests.*")
      @visit_tests = @visit_tests.to_a.group_by { |t| t.created_at.to_date }
    end
  end

  def summary
    @from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    @to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })
    @visits = current_location.visits.where("(created_at >= ? AND created_at <= ?)", @from_date, @to_date)
    @tokens = current_location.tokens.where("(created_at >= ? AND created_at <= ?)", @from_date, @to_date)
    @paid_visits = current_location.visits.where("(created_at >= ? AND created_at <= ? AND payment_program = ?)", @from_date, @to_date, "Paid Patient")
    @tests = Test.joins(visit_tests: :visit).where("visit_tests.created_at >= ? AND visit_tests.created_at <= ? AND location_id = ?", @from_date, @to_date, current_location).select("tests.test_code, COUNT(tests.test_code) AS count_all").group(:test_code)
  end

  def peak_time
    @from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    @to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

    @completed_tokens = line_chart_tokens("completed")
    @discarded_tokens = line_chart_tokens("discarded")
    @time_in_tokens = line_chart_tokens("time_in")
    @visit_reg_tokens = line_chart_tokens("visit_registered")
    tokens = line_chart_tokens

    @peak_hour = tokens.max_by { |k,v| v }
    
    @tokens = [{ name: "Completed (#{tokens_count('completed')})", data: @completed_tokens }, { name: "Discarded (#{tokens_count('discarded')})", data: @discarded_tokens }, { name: "Time in (#{tokens_count('time_in')})", data: @time_in_tokens }, { name: "Visit Registered (#{tokens_count('visit_registered')})", data: @visit_reg_tokens }]
  end

private

  def tokens_count(state)
    Token.where("(created_at >= ? AND created_at <= ?) AND state = ?", @from_date, @to_date, state).count
  end

  def line_chart_tokens(state=nil)
    if state
      current_location.tokens.where("(created_at >= ? AND created_at <= ?) AND state = ?", @from_date, @to_date, state).group_by_hour(:created_at).count
    else
      current_location.tokens.where("(created_at >= ? AND created_at <= ?)", @from_date, @to_date).group_by_hour(:created_at).count
    end
  end

  def pie_chart_tokens
    @tokens_30 = @tokens.to_a.select { |t| (t.completed_at - t.created_at) <= 1800 }
    @tokens_30 = [] if @tokens_30.nil?

    @tokens_40 = @tokens.to_a.select { |t| (((t.completed_at - t.created_at) > 1800) && ((t.completed_at - t.created_at) <= 2400)) }
    @tokens_40 = [] if @tokens_40.nil?

    @tokens_60 = @tokens.to_a.select { |t| (((t.completed_at - t.created_at) > 2400) && ((t.completed_at - t.created_at) <= 3600)) }
    @tokens_60 = [] if @tokens_60.nil?

    @tokens_61 = @tokens.to_a.select { |t| (t.completed_at - t.created_at) > 3600 }
    @tokens_61 = [] if @tokens_61.nil?

    @pie_tokens = { "Seen in <= 30 minutes" => @tokens_30.size, "Seen in 31-40 minutes" => @tokens_40.size, "Seen in 41-60 minutes" => @tokens_60.size, " Seen in >60 minutes" => @tokens_61.size}
  end

  def formatted_date(date, options)
    time = options[:time]
    time = (options[:type] == 'start_time' ? DateTime.now.beginning_of_day.strftime("%H:%M") : DateTime.now.end_of_day.strftime("%H:%M")) if time.blank?
    date = Date.today.to_s if params[:start_date].blank?
    (time + ' ' + date).to_datetime
  end
end
