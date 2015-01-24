#
# Cookbook Name:: cookbook_moodle
# Recipe:: mysql
#

root_password = node['cookbook_moodle']['database']['root_password']
if root_password
  Chef::Log.info %(Set root password to node['cookbook_moodle']['database']['root_password'])
  Chef::Log.info root_password
  node.set['mysql']['server_root_password'] = root_password
  node.set['mysql']['server_repl_password'] = root_password
  node.set['mysql']['server_debian_password'] = root_password
end

# Set the mysql version we want
node.set['mysql']['version'] = node["cookbook_moodle"]["mysql_version"]

# Install the MySQL service
mysql_service 'default' do
  initial_root_password root_password
  version node["mysql"]["version"]
  action [:create, :start]
end

# Install the MySQL Client
mysql_client 'default' do
  action :create
  version node["mysql"]["version"]
end

include_recipe "database::mysql"

# Setup the connection information
mysql_connection_info = {
    :host => node['cookbook_moodle']['database']['host'],
    :username => 'root',
    :password => root_password
}

mysql_database node['cookbook_moodle']['database']['database_name'] do
  connection mysql_connection_info
  encoding 'UTF8'
  collation 'utf8_unicode_ci'
  action :create
end

mysql_database_user node['cookbook_moodle']['database']['username'] do
  connection mysql_connection_info
  action [:create, :grant]
  password(node['cookbook_moodle']['database']['password'])
end

template '/etc/mysql/conf.d/mysite.cnf' do
  owner 'mysql'
  owner 'mysql'
  source 'mysite.cnf.erb'
  variables(
      :max_allowed_packet => node['cookbook_moodle']['mysql']['max_allowed_packet']
  )
  notifies :restart, 'mysql_service[default]'
end