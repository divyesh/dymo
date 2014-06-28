module ApplicationHelper
  def next_state_link(token)
    case token.current_state.name
    when :time_in
      link_to 'Add visit', new_visit_path(patient_id: token.patient)
    when :visit_registered
      ((form_for token, url: done_token_path(token), method: :post do |f|
        f. submit 'Done'
      end) + (form_for token, url: reject_token_path(token), method: :post do |f|
        f. submit 'Reject'
      end) + (form_for token, url: discard_token_path(token), method: :post do |f|
        f. submit 'Discard'
      end)).html_safe
    when :completed
      "-"
    end
  end
end
