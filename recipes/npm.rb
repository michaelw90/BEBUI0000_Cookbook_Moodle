#
# Cookbook Name:: cookbook_moodle
# Recipe:: npm
#

# Install from source
node.set['nodejs']['install_method'] = 'source'

# Set the node version and checksum
node.set['nodejs']['version'] = node['cookbook_moodle']['nodejs']['version']
node.set['nodejs']['source']['checksum'] = node['cookbook_moodle']['nodejs']['checksum']

# Install npm itself
include_recipe 'nodejs::npm'

Array(node['cookbook_moodle']['npm_packages']).each_with_index do |package_name, index|
  nodejs_npm package_name do
    action :install
  end
end