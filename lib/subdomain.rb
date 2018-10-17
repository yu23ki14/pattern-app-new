class Subdomain
  def self.matches?(request)
    if request.subdomain.present?
      if Rails.env.production?
        subdomain = ActionDispatch::Http::URL.extract_subdomains(request.host, 0).first
      else
        subdomain = ActionDispatch::Http::URL.extract_subdomains(request.subdomain, 0).first
      end
      return subdomain.present? && subdomain != "www"
    else
      return false
    end
  end
end