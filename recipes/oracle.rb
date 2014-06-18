#
# Cookbook Name:: cookbook_moodle
# Recipe:: oracle
#

# Disable the install of php from phpbox
node.set["cookbook_phpbox"]["php"] = false

configure_options = node['cookbook_moodle']['oracle']['php']['configure_options'].join(' ')
bin = node['cookbook_moodle']['oracle']['php']['bin']
version = node['cookbook_moodle']['oracle']['php']['version']
php_url = node['cookbook_moodle']['oracle']['php']['url']
conf_dir = node['cookbook_moodle']['oracle']['php']['conf_dir']
ext_conf_dir = node['cookbook_moodle']['oracle']['php']['ext_conf_dir']
template = node['cookbook_moodle']['oracle']['php']['template']
directives = node['cookbook_moodle']['oracle']['php']['directives']
ext_dir_prefix = ''

include_recipe 'build-essential'
include_recipe 'xml'

# Provide the basic zip file on the server
cookbook_file node['cookbook_moodle']['oracle']['basic_zip'] do
  path File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['basic_zip'])
  action :create_if_missing
end

# Provide the sdk zip file on the server
cookbook_file node['cookbook_moodle']['oracle']['sdk_zip'] do
  path File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['sdk_zip'])
  action :create_if_missing
end

# Create the oracle directory
directory "/usr/lib/oracle" do
  action :create
  recursive true
end

# Unzip the files into the same directory
execute "Unzip basic into directory" do
  command "unzip -o #{File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['basic_zip'])} -d /usr/lib/oracle/"
end
execute "Unzip sdk into directory" do
  command "unzip -o #{File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['sdk_zip'])} -d /usr/lib/oracle/"
end

# Create some symbolic links
link "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libclntsh.so" do
  to "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libclntsh.so.#{node['cookbook_moodle']['oracle']['version']}"
end
link "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libocci.so" do
  to "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libocci.so.#{node['cookbook_moodle']['oracle']['version']}"
end

#magic_shell_environment 'ORACLE_HOME' do
  #value "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}"
#end


# Install the necessary packages for php
%w{libicu-dev libaio1 libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev libt1-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

# Download the package
remote_file "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.gz" do
  source "#{php_url}/php-#{version}.tar.gz/from/this/mirror"
  mode '0644'
  not_if "which #{bin}"
end

# Install the package
bash 'build php' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxf php-#{version}.tar.gz
  (cd php-#{version} && #{ext_dir_prefix} ./configure #{configure_options})
  (cd php-#{version} && make && make install)
  EOF
  not_if "which #{bin}"
end

# Create the configuration directory
directory conf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

# Create the extensions configuration directory
directory ext_conf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

# Create the php.ini file from the template
template "#{conf_dir}/php.ini" do
  source template
  owner 'root'
  group 'root'
  mode '0644'
  variables(:directives => directives)
end

# Create the fpm directorys
directory node['cookbook_moodle']['oracle']['php-fpm']['conf_dir'] do
  action :create
  recursive true
end
directory node['cookbook_moodle']['oracle']['php-fpm']['pool_conf_dir'] do
  action :create
  recursive true
end

#php_fpm_package_name = 'php5-fpm'
#php_fpm_service_name = 'php5-fpm'

#package php_fpm_package_name do
  #action :upgrade
#end

# Create the php-fpm configuration file
template node['cookbook_moodle']['oracle']['php-fpm']['conf_file'] do
  source "php-fpm.conf.erb"
  mode 00644
  owner "root"
  group "root"
  #notifies :restart, "service[php-fpm]"
end

#service "php-fpm" do
  #provider ::Chef::Provider::Service::Upstart
  #service_name php_fpm_service_name
  #supports :start => true, :stop => true, :restart => true, :reload => true
  #action [ :enable, :start ]
#end

if node['cookbook_moodle']['oracle']['php-fpm']['pools']
  node['cookbook_moodle']['oracle']['php-fpm']['pools'].each do |params|
    template "#{node['cookbook_moodle']['oracle']['php-fpm']['pool_conf_dir']}/#{params[:name]}.conf" do
      only_if "test -d #{node['cookbook_moodle']['oracle']['php-fpm']['pool_conf_dir']} || mkdir -p #{node['cookbook_moodle']['oracle']['php-fpm']['pool_conf_dir']}"
      source 'pool.conf.erb'
      owner 'root'
      group 'root'
      mode 00644
      cookbook params[:cookbook] || 'php-fpm'
      variables(
        :pool_name => params[:name],
        :listen => params[:listen],
        :listen_owner => params[:listen_owner] || node['cookbook_moodle']['oracle']['php-fpm']['listen_owner'],
        :listen_group => params[:listen_group] || node['cookbook_moodle']['oracle']['php-fpm']['listen_group'],
        :listen_mode => params[:listen_mode] || node['cookbook_moodle']['oracle']['php-fpm']['listen_mode'],
        :allowed_clients => params[:allowed_clients],
        :user => params[:user],
        :group => params[:group],
        :process_manager => params[:process_manager],
        :max_children => params[:max_children],
        :start_servers => params[:start_servers],
        :min_spare_servers => params[:min_spare_servers],
        :max_spare_servers => params[:max_spare_servers],
        :max_requests => params[:max_requests],
        :catch_workers_output => params[:catch_workers_output],
        :security_limit_extensions => params[:security_limit_extensions] || node['cookbook_moodle']['oracle']['php-fpm']['security_limit_extensions'],
        :php_options => params[:php_options] || {},
        :params => params
      )
    end
  end
  #notifies :restart, "service[php-fpm]"
end