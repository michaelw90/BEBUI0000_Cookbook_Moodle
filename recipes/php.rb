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
    'session.save_handler' => 'memcache',
    'session.save_path' => node['cookbook_moodle']['aws']['elasticache'],
    'upload_max_filesize' => '100M',
    'post_max_size' => '100M',
    'max_execution_time' => '600',
    'opcache.enable' => '1',
    'oci8.statement_cache_size' => 0,
    'cgi.fix_pathinfo' => 0
}

node.set['php-fpm']['pools'] = {
  "www" => {
        :name => "www",
        :listen => "127.0.0.1:9001",
        :php_options => {
            'php_admin_value[date.timezone]' => 'Europe/London',
            'php_admin_flag[short_open_tag]' => 'off',
            'php_admin_flag[magic_quotes_gpc]' => 'off',
            'php_admin_flag[register_globals]' => 'off',
            'php_admin_flag[session.autostart]' => 'off',
            'php_admin_flag[session.save_handler]' => 'memcache',
            'php_admin_flag[session.save_path]' => node['cookbook_moodle']['aws']['elasticache'],
            'php_admin_value[upload_max_filesize]' => '100M',
            'php_admin_value[post_max_size]' => '100M',
            'php_admin_value[max_execution_time]' => 600,
            'php_admin_value[opcache.enable]' => 1,
            'php_admin_value[oci8.statement_cache_size]' => 0,
            'php_admin_value[cgi.fix_pathinfo]' => 0
        }
    }
}

include_recipe "php"
include_recipe "php-fpm"

package "php5-curl" do
  action :install
end

package "php5-gd" do
  action :install
end

package "php5-intl" do
  action :install
end

package "php5-mysql" do
  action :install
end

package "php5-sqlite" do
  action :install
end

package "php5-xmlrpc" do
  action :install
end

Array(node["cookbook_moodle"]["php_packages"]).each_with_index do |package_name, index|
  package package_name do
    action :install
  end
end

Array(node["cookbook_moodle"]["php_pears"]).each_with_index do |pear_name, index|
  php_pear pear_name do
    action :install
  end
end

service "php-fpm" do
  action :restart
end