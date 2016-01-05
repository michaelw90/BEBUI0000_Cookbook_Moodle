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
template node['cookbook_moodle']['cronic'] do
  source 'cronic.erb'
  mode '755'
end

# Deduce the site and data directories
site_dir = "#{node['cookbook_moodle']['appdir']}/#{node['cookbook_moodle']['appname']}/current/public"
data_dir = "#{node['cookbook_moodle']['appdir']}/#{node['cookbook_moodle']['appname']}/shared/data"

# Create a cron job
cron 'moodle maintenance cron' do
  hour node['cookbook_moodle']['cron_hour']
  minute node['cookbook_moodle']['cron_minute']
  command "#{node['cookbook_moodle']['cronic']} php #{site_dir}/admin/cli/cron.php"
end

# Only create the directories and ocnfig file if we're localhost.
if node['cookbook_moodle']['hostname'] == 'localhost'

  # Create the site and data directories with the right permissions
  [site_dir, data_dir].each do |dir|
    directory dir do
      action :create
      recursive true
      group node['cookbook_moodle']['group']
    end
  end

  www_root = node['cookbook_moodle']['address']
  if node['cookbook_moodle']['listen_port'] && node['cookbook_moodle']['listen_port'] != "80"
    www_root += ":#{node['cookbook_moodle']['listen_port']}"
  end

  if node['cookbook_moodle']['generate_config']
    # Copy the configuration template into the moodle directory
    template "#{site_dir}/config.php" do
      source 'config.php.erb'
      mode '755'
      variables(
          :database_user     => node['cookbook_moodle']['database']['username'],
          :database_password => node['cookbook_moodle']['database']['password'],
          :database_name => node['cookbook_moodle']['database']['database_name'],
          :www_root => www_root,
          :data_dir => data_dir
      )
    end
  end

  # Change the owner of the data directory
  execute "Change owner of #{data_dir}" do
    command "chown -R #{node['cookbook_moodle']['user']}:#{node['cookbook_moodle']['group']} #{data_dir}"
  end

end