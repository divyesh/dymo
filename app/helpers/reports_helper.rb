module ReportsHelper
  def waiting_time(time_in_seconds)
    if time_in_seconds > 60
      time_in_seconds = (time_in_seconds/60).to_i
      "#{time_in_seconds} minutes"
    elsif time_in_seconds > 3600
      time_in_seconds = (time_in_seconds/3600).to_i
      "#{time_in_seconds} hours"
    else
      "#{time_in_seconds} seconds"
    end
  end
end
