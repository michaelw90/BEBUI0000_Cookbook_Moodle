#
# Cookbook Name:: cookbook_moodle
# Recipe:: nginx
#
# Install Nginx from source to support custom Nginx modules in future.
#

::Chef::Recipe.send(:include, PHPBox::Helpers)

# Set the initialisation style for nginx
set['nginx']['init_style'] = "init"

# Install nginx from source
include_recipe "nginx::source"

# Setup the nginx site configuration
app = {}
app['appname'] = node['cookbook_moodle']['appname']
app['hostname'] = node['cookbook_moodle']['hostname']
app['nginx_config'] = {
    'template_name' => 'nginx_vhost_moodle.conf.erb',
    'template_cookbook' => 'cookbook_moodle',
    'listen_port' => "80"
}
app_dir = ::File.join(node['appbox']['apps_dir'], app['appname'], 'current')
setup_nginx_site(app, app_dir)