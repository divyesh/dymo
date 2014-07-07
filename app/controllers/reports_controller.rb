class ReportsController < ApplicationController
  def index
    date = filter_date
    @tokens = Token.where("(created_at >= ? AND created_at <= ?) AND (state = ? OR state = ?)", date.beginning_of_day, date.end_of_day, "completed", "discarded")
  end
end
