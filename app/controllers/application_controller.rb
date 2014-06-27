class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :detect_device_variant

  def mobile?
    request.user_agent.downcase =~ /|android|touch|webos|hpwos/
  end
  helper_method :mobile?


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
