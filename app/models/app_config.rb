class AppConfig < ActiveRecord::Base
  def self.print_token_url
    ap = AppConfig.where("name = ?", "print_token_url").first
    ap ? ap.value : "http://mh-it-6003.mhlab.ca/RestServiceImpl.svc/Print/"
  end

  def self.token_generation_interval
    ap = AppConfig.where("name = ?", "token_generation_interval").first
    ap ? ap.value.to_i : 1800
  end
end
