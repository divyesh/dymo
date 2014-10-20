module ApplicationHelper
  def next_state_link(token, location)
    case token.current_state.name
    when :time_in
      ((link_to 'Register Patient', new_patient_visit_path(token.patient)) + " / " +  (link_to "Discard", new_location_token_token_history_path(location, token,{ note: "discarded" }))).html_safe
    when :visit_registered
      ((form_for token, url: done_location_token_path(current_location, token), method: :post, html: { class: 'inline' } do |f|
        f. submit 'Process'
      end) + " / " + (link_to "Discard", new_location_token_token_history_path(location, token, {note: "discarded"}))).html_safe
    end
  end

  def destroy_link(model)
    if can? :destroy, model
      (link_to "Destroy", model, method: :delete, data: { confirm: 'Are you sure?' }).html_safe
    end
  end

  def print_physician_label_link(visit, physician, text='')
    raw "<a href=\"javascript:void(0);\" " +
    "healthnumber=\"#{visit.patient.healthnumber} #{visit.patient.version_code}\" " +
    "expiry=\"#{formatted_date(visit.patient.health_expiry_date)}\" " +
    "birthdate=\"#{formatted_date(visit.patient.birthdate)}\" " +
    "sex=\"#{visit.patient.gender}\" " +
    "address1=\"#{visit.patient.address1}\" " +
    "address2=\"#{visit.patient.address2}\" " +
    "homephone=\"#{visit.patient.home_phone}\" " +
    "mobile=\"#{visit.patient.mobile}\" " +
    "patientName=\"#{visit.patient.lastname} , #{visit.patient.firstname} #{visit.patient.middlename}\" " +
    "physician=\"#{physician.fullname_with_physician_number}\" " +
    "visiteddate=\"#{strftime_date(visit.visitdate)}\" " +
    "city=\"#{visit.patient.city}\" " +
    "province=\"#{visit.patient.province}\" " +
    "postalcode=\"#{visit.patient.postal_code}\" " +
    "class=\"print-label-link\"> " +
    "#{text}#{physician.fullname_with_physician_number}</a>"
  end

  private
    def formatted_date(date)
      date.nil? ? '' : date.to_formatted_s(:db)
    end

    def strftime_date(date)
      date.nil? ? "" : date.strftime("%m/%d/%Y")
    end
end
