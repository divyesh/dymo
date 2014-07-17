module ReportsHelper
  def waiting_time(time_in_seconds)
    text = "#{time_in_seconds} seconds"
    if time_in_seconds >= 3600
      hours = (time_in_seconds/3600).to_i
      text = "#{hours} hours"
      minutes = ((time_in_seconds%3600).to_i/60).to_i
      text = text + " #{minutes} minutes" if minutes > 0
      seconds = ((time_in_seconds%3600).to_i%60).to_i
      text = text + " #{seconds} seconds" if seconds > 0
    elsif time_in_seconds >= 60
      minutes = (time_in_seconds/60).to_i
      text = "#{minutes} minutes"
      seconds = (time_in_seconds%60).to_i
      text = text + " #{seconds} seconds" if seconds > 0
    end
    text
  end

  def waiting_icon(time_in_seconds)
    if time_in_seconds >= 3600
      "red-item-icon"
    elsif time_in_seconds >= 60
      minutes = (time_in_seconds/60).to_i
      if minutes >= 30
        "gray-item-icon"
      elsif minutes > 30 && minutes <= 40
        "darkgray-item-icon"
      elsif minutes > 40 && minutes <= 60
        "black-item-icon"
      elsif minutes > 40 && minutes <= 60
        "red-item-icon"
      else
        "green-item-icon"
      end
    else
      "green-item-icon"
    end
  end
end
