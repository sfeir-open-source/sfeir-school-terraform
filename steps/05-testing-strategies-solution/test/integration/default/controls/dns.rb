gcp_project_id = attribute('project_id', description: 'The GCP project identifier.') 

control 'private-dns' do
  describe google_dns_managed_zone(project: gcp_project_id, zone: 'demo-local') do 
    it { should exist }
    its('name_servers') { should eq ['ns-gcp-private.googledomains.com.'] }
  end
end
