class Subdomain
  def self.matches?(request)
    if request.subdomain.present?
      subdomain = ActionDispatch::Http::URL.extract_subdomains(request.subdomain, 0).first
      return subdomain.present? && subdomain != "www"
    else
      return false
    end
  end
end