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

    pie_chart_tokens

    respond_to do |format|
      format.html
      format.csv { send_data @tokens.to_csv }
      format.xls
    end
  end

  def migrate_physicians
    Visit.where("physician_id IS NOT NULL").each do |visit|
      PhysicianVisit.create(visit_id: visit.id, physician_id: visit.physician_id)
    end
    redirect_to root_path, notice: "Migrated successfully. Total #{PhysicianVisit.count}"
  end

  def physician_patients
    unless params[:filter_physician_id].blank?
      @physician = Physician.find(params[:filter_physician_id])

      if params[:all_patients] == 'yes'
        @visits = @physician.visits
      else
        from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
        to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

        @visits = @physician.visits.where("(physician_visits.created_at >= ? AND physician_visits.created_at <= ?)", from_date, to_date)
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
      @physicians = Physician.joins(:visits).where("(visits.created_at >= ? AND visits.created_at <= ?)", @from_date, @to_date).distinct
    else
      @visit_tests = VisitTest.where("visit_tests.created_at >= ? AND visit_tests.created_at <= ?", @from_date, @to_date)
      @visit_tests = @visit_tests.to_a.group_by { |t| t.created_at.to_date }
    end
  end

  def summary
    @from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    @to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })
    @visits = Visit.where("(created_at >= ? AND created_at <= ?)", @from_date, @to_date)
    @tokens = Token.where("(created_at >= ? AND created_at <= ?)", @from_date, @to_date)
    @paid_visits = Visit.where("(created_at >= ? AND created_at <= ? AND payment_program = ?)", @from_date, @to_date, "Paid Patient")
    @tests = Test.joins(:visit_tests).where("visit_tests.created_at >= ? AND visit_tests.created_at <= ?", @from_date, @to_date).select("tests.test_code, COUNT(tests.test_code) AS count_all").group(:test_code)
  end

  def peak_time
    from_date = formatted_date(params[:start_date], { time: params[:start_time], type: 'start_time' })
    to_date = formatted_date(params[:end_date], { time: params[:end_time], type: 'end_time' })

    @tokens = Hash.new

    (from_date.to_i..to_date.to_i).step(1.hour).each_with_index do |date, index|
      key = "#{Time.at(date).strftime('%Y/%m/%d, %H:%M')} - #{(Time.at(date) + 1.hour).strftime('%Y/%m/%d, %H:%M')}"
      value = Token.where("(created_at >= ? AND created_at <= ?)", Time.at(date), Time.at(date) + 59.minute).count
      @tokens[key] = value
    end

    @peak_hour = @tokens.max_by { |k,v| v }
  end

  private

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
