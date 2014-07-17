class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # before_action :detect_device_variant

  # before_action :authenticate_user!

  def mobile?
    request.user_agent.downcase =~ /|android|touch|webos|hpwos/
  end
  helper_method :mobile?

  def parse_healthcard(params_search)
    options = { healthnumber: params_search }
    if params_search && params_search.length >= 50

      hn_arr = params_search.split('?')
      if (hn_arr.length > 0)
        hn_arr = hn_arr[0].split('^')

        # Health number
        healthnumber = hn_arr[0][ hn_arr[0].length - 10, hn_arr[0].length ]

        name_arr = hn_arr[1].split('/')

        # Lastname Firstname Middlename
        lastname = name_arr[0].strip
        firstname = name_arr[1].strip
        middlename = name_arr.length > 2 ? name_arr[2].strip : ''
        gender = hn_arr[2][7,1] == "1" ? "M" : "F"

        # Birthdate
        year = hn_arr[2][8, 4]
        month = hn_arr[2][12, 2]
        day = hn_arr[2][14, 2]

        birthdate = year + '/' + month + '/' + day

        # Health expiry date
        expiry_year = hn_arr[2][0, 2]
        expiry_month = hn_arr[2][2, 2]
        expiry_day = day

        health_expiry_date = '20' + expiry_year + '/' + expiry_month + '/' + expiry_day

        # Version code
        version_code = hn_arr[2][16, 2]

        patient = Patient.where(healthnumber: healthnumber)

        options = { healthnumber: healthnumber, lastname: lastname, firstname: firstname, version_code: version_code, birthdate: birthdate, gender: gender, health_expiry_date: health_expiry_date }
      end
    end
    options
  end
  helper_method :parse_healthcard

  def filter_date(sym_name)
    params[sym_name].nil? ? DateTime.now : DateTime.civil(params[sym_name][:year].to_i, params[sym_name][:month].to_i, params[sym_name][:day].to_i)
  end
  helper_method :filter_date

  private

    def detect_device_variant
      case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :phone
      end
    end
end
