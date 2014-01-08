#
# Cookbook Name:: cookbook_moodle
# Recipe:: moodle
#


# Create the cronic directory
# Cronic is a cron job report wrapper
directory File.dirname(node['cookbook_moodle']['cronic']) do
  action :create
  recursive true
end

# Create the cronic file
template cronic do
  source 'cronic.erb'
  mode '755'
end

# Deduce the site and data directories
site_dir = "/home/apps/#{node['cookbook_moodle']['appname']}/current"
data_dir = "/home/apps/#{node['cookbook_moodle']['appname']}/shared/data"

# Create the site and data directories with the right permissions
[site_dir, data_dir].each do |dir|
  directory dir do
    action :create
    recursive true
    group node['cookbook_moodle']['group']
  end
end

# Clone the git repository branch to the site directory
git site_dir do
  repository "git://git.moodle.org/moodle.git"
  reference node[:moodle][:branch]
end

# Change the owner of the data directory
execute "Change owner of #{data_dir}" do
  command "chown -R #{node['cookbook_moodle']['user']}:#{node['cookbook_moodle']['group']} #{data_dir}"
end

# Create a cron job
cron 'moodle maintenance cron' do
  hour node['cookbook_moodle']['cron_hour']
  minute 0
  command "#{node['cookbook_moodle']['cronic']} php #{site_dir}/admin/cli/cron.php"
end