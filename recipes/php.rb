#
# Cookbook Name:: cookbook_moodle
# Recipe:: php
#

# Set the php initialisation options
node.set['php']['directives'] = {
  'date.timezone' => 'Europe/London',
  'short_open_tag' => 'Off',
  'magic_quotes_gpc' => 'Off',
  'register_globals' => 'Off',
  'session.autostart' => 'Off',
  'upload_max_filesize' => '8M',
  'max_execution_time' => '600'
}

package "php5-curl" do
  action :install
end

package "php5-gd" do
  action :install
end

package "php5-intl" do
  action :install
end

package "php5-xmlrpc" do
  action :install
end


service "php-fpm" do
  action :restart
end