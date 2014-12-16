#
# Cookbook Name:: cookbook_moodle
# Recipe:: mysql
#

root_password = node['cookbook_moodle']['database']['root_password']
if root_password
  Chef::Log.info %(Set root password to node['cookbook_moodle']['database']['root_password'])
  Chef::Log.info root_password

  # Include the mysql recipes
  mysql_service 'default' do
    initial_root_password root_password
    action [:create, :start]
  end

  mysql_client 'default' do
    action :create
  end

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

  template '/etc/mysql/conf.d/mysite.cnf' do
    owner 'mysql'
    owner 'mysql'
    source 'mysite.cnf.erb'
    variables(
        :max_allowed_packet => node['cookbook_moodle']['mysql']['max_allowed_packet']
    )
    notifies :restart, 'mysql_service[default]'
  end

end