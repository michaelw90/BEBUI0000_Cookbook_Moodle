#
# Cookbook Name:: cookbook_moodle
# Recipe:: php
#

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