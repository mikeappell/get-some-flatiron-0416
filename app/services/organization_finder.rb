class OrganizationFinder
  def self.find_or_create(email_address_params)
    domain = /@(.+)/.match(email_address_params)
    Organization.find_or_create_by(domain_name: domain[1])
  end

end
