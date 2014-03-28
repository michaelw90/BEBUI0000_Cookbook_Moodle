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

# Trying some optimisations, as i'm having trouble with
# the database being nailed
node.set['mysql']['tunable']['max_connections']         = '20'
node.set['mysql']['tunable']['remove_anonymous_users']  = true
node.set['mysql']['tunable']['key_buffer_size']         = '200M'

# Include the mysql recipes
include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "database::mysql"

# Setup the connection information
mysql_connection_info = {
    :host => 'localhost',
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


