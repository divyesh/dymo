class Token < ActiveRecord::Base
  include Workflow
  workflow_column :state

  belongs_to :patient
  has_many :token_histories

  workflow do
    state :time_in do
      event :add_visit, transitions_to: :visit_registered
    end
    state :visit_registered do
      event :done, transitions_to: :completed
      event :discard, transitions_to: :discared
    end
    state :completed
    state :discared
  end

  def self.new_time_in_token(patient)
    Token.new({
      patient: patient,
      no: Token.where("date(created_at) = ?", Date.today).size + 1
    })

    token.save!

    token_history = token.token_histories.build
    token_history.punch_in_time = token.created_at
    token_history.note = "Time in"
    token_history.save!
  end

  private
    def add_visit
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "Visit registered"
      token_history.save!
    end

    def done
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "Completed"
      token_history.save!
    end

    def discard
      token_history = self.token_histories.build
      token_history.punch_in_time = DateTime.now
      token_history.note = "Discarded"
      token_history.save!
    end
end
