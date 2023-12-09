gcp_project_id = attribute('project_id', description: 'The GCP project identifier.')
dns_zone_name = attribute('dns')

control 'private-dns' do
  describe google_dns_managed_zone(project: gcp_project_id, zone: dns_zone_name) do
    it { should exist }
    its('name_servers') { should eq ['ns-gcp-private.googledomains.com.'] }
  end
end
