module ApplicationHelper
  def next_state_link(token)
    case token.current_state.name
    when :time_in
      ((link_to 'Register Patient', new_patient_visit_path(token.patient)) + " / " +  (link_to "Discard", new_token_token_history_path(token,{ note: "discarded" }))).html_safe
    when :visit_registered
      ((form_for token, url: done_token_path(token), method: :post, html: { class: 'inline' } do |f|
        f. submit 'Process'
      end) + " / " + (link_to "Discard", new_token_token_history_path(token, {note: "discarded"}))).html_safe
    end
  end

  def destroy_link(model)
    if can? :destroy, model
      (link_to "Destroy", model, method: :delete, data: { confirm: 'Are you sure?' }).html_safe
    end
  end
end
