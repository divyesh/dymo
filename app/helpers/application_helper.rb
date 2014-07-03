module ApplicationHelper
  def next_state_link(token)
    case token.current_state.name
    when :time_in
      link_to 'Add physician', edit_patient_path(token.patient)
    when :visit_registered
      ((form_for token, url: done_token_path(token), method: :post, html: { class: 'inline' } do |f|
        f. submit 'Done'
      end) + (form_for token, url: discard_token_path(token), method: :post, html: { class: 'inline' } do |f|
        f. submit 'Discard'
      end)).html_safe
    when :completed
      "-"
    end
  end
end
