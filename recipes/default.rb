#
# Cookbook Name:: cookbook_moodle
# Recipe:: default
#

moodle_app = {}
moodle_app['appname'] = node['cookbook_moodle']['appname']
moodle_app['hostname'] = node['cookbook_moodle']['hostname']

node.set['cookbook_phpbox']['webserver'] = 'nginx'
node.set['cookbook_phpbox']['apps'] = [moodle_app]

node.set['php-fpm']['pools'] = [
  {
    :name => "www",
    :listen => "127.0.0.1:9001"
  }
]

include_recipe "git"
include_recipe "cookbook_phpbox"
include_recipe "cookbook_moodle::users"
include_recipe "cookbook_moodle::php"