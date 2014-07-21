class AppConfig < ActiveRecord::Base
  def self.print_token_url
    AppConfig.where("name = ?", "print_token_url").first || "http://mh-it-6003.mhlab.ca/RestServiceImpl.svc/Print/"
  end
end
