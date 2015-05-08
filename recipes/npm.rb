#
# Cookbook Name:: cookbook_moodle
# Recipe:: npm
#

# Set the node version
node.set['nodejs']['version'] = node['cookbook_moodle']['nodejs']['version']

# Install npm itself
include_recipe 'nodejs::npm'

Array(node['cookbook_moodle']['npm_packages']).each_with_index do |package_name, index|
  nodejs_npm package_name do
    action :install
  end
end