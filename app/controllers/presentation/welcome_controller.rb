class Presentation::WelcomeController < ApplicationController
  before_action :set_subdomain
  
  def index
  end
  
  private
  def set_subdomain
    @subdomain = ActionDispatch::Http::URL.extract_subdomains(request.subdomain, 0).first
  end
end