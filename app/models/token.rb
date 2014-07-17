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

  def self.new_time_in_token(patient)
    token = Token.new({
      patient: patient,
      no: Token.where("(created_at >= ? AND created_at <= ?)", DateTime.now.beginning_of_day, DateTime.now.end_of_day).size + 1
    })

    token.save!

    token_history = token.token_histories.build
    token_history.punch_in_time = token.created_at
    token_history.note = "time_in"
    token_history.save!
    token
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
