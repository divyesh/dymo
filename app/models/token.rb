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
      event :reject, transitions_to: :rejected
      event :discard, transitions_to: :discared
    end
    state :completed
    state :rejected
    state :discared
  end

  private
    def add_visit
      token_history = self.token_histories.build
      token_history.punch_in_time = self.created_at
      token_history.note = "visit registered"
      token_history.save!
    end

    def done
      token_history = self.token_histories.build
      token_history.punch_in_time = self.created_at
      token_history.note = "completed"
      token_history.save!
    end

    def reject
      token_history = self.token_histories.build
      token_history.punch_in_time = self.created_at
      token_history.note = "rejected"
      token_history.save!
    end

    def discard
      token_history = self.token_histories.build
      token_history.punch_in_time = self.created_at
      token_history.note = "discarded"
      token_history.save!
    end
end
