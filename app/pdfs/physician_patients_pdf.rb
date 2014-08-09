class PhysicianPatientsPdf < Prawn::Document
  def initialize(physician, visits)
    super(top_margin: 70)
    @physician = physician
    @visits = visits
    physician_details
    physician_patients_table
  end

  def physician_details
    text "#{@physician.physician_full_name} Medical Clinic", size: 16, style: :bold

    move_down 10

    text "#{@physician.address1}"
    text "#{@physician.address2}"
    text "#{@physician.city}"
    text "#{@physician.province}"
    text "#{@physician.country}"
    text "#{@physician.postal_code}"

    move_down 10

    text "Phone: #{@physician.phone}"
    text "Emergency Number: #{@physician.emergency_number}"
    text "Email: #{@physician.email}"
  end

  def physician_patients_table
    move_down 20
    table physician_patients_rows do
      row(0).font_style = :bold
      row(0).align = :center
      columns(2).align = :center
      columns(3).width = 100
      self.header = true
    end
  end

  def physician_patients_rows
    [["Date", "Patient Name", "ECG (Yes/No)", ""]] +
    @visits.map do |visit|
      [visit.visitdate.nil? ? "" : visit.visitdate.to_date.to_formatted_s(:long), visit.patient.fullname_with_health_insurance_number, (visit.tests.where("test_code = ?", "ECG").count > 0 ? "Yes" : "No"), ""]
    end
  end
end
