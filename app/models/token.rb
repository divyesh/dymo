class Token < ActiveRecord::Base
  include Workflow
  workflow_column :state

  belongs_to :patient
  has_many :token_histories, dependent: :destroy

  workflow do
    state :time_in do
      event :add_visit, transitions_to: :visit_registered
      event :discard, transitions_to: :discarded
    end
    state :visit_registered do
      event :done, transitions_to: :completed
      event :discard, transitions_to: :discarded
    end
    state :completed
    state :discarded
  end

  def generatable?
    (((DateTime.now.to_time - self.created_at.to_time).to_i)/AppConfig.token_generation_interval) > 0
  end

  def visit_registered_time
    th = token_histories.where("note = ?", "visit_registered").first
    if th
      th.punch_in_time
    end
  end

  def waiting_period_1
    th = token_histories.where("note = ?", "visit_registered").first
    (th.punch_in_time.to_time - created_at.to_time).to_i
  end

  def completed_time
    th = token_histories.where("note = ?", "completed").first
    th.punch_in_time
  end

  def waiting_period_2
    th1 = token_histories.where("note = ?", "visit_registered").first
    th2 = token_histories.where("note = ?", "completed").first
    (th2.punch_in_time.to_time - th1.punch_in_time.to_time).to_i
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Token #", "OHIP", "Time in", "Visit Registered", "Waiting Period 1", "Completed", "Waiting Period 2", "Total Wait Time"]
      all.each do |token|
        csv << [token.no, "#{token.patient.healthnumber} #{token.patient.version_code}", token.created_at.to_formatted_s(:long), token.visit_registered_time.to_formatted_s(:long), waiting_time(token.waiting_period_1), token.completed_time.to_formatted_s(:long), waiting_time(token.waiting_period_2), waiting_time(token.waiting_period_1 + token.waiting_period_2)]
      end
    end
  end

  def self.waiting_time(time_in_seconds)
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

  private
    def add_visit
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "visit_registered"
      token_history.save!
    end

    def done
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "completed"
      token_history.save!
      self.completed_at = DateTime.now
      self.save!
    end

    def discard
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "discarded"
      token_history.save!
    end
end
