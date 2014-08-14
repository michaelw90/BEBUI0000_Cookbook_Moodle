#
# Cookbook Name:: cookbook_moodle
# Recipe:: newrelic
#

if node['cookbook_moodle']['newrelic']
  newrelic_licence_key = node['cookbook_moodle']['newrelic']['license_key']
  if newrelic_licence_key
    node.set['newrelic']['license'] = newrelic_licence_key
    node.set['newrelic']['install_dir'] = '/opt/newrelic'
    node.set['newrelic']['php-agent']['web_server']['service_name'] = 'nginx'
    include_recipe 'newrelic::repository'
    include_recipe 'newrelic::server-monitor-agent'
    include_recipe 'newrelic::php-agent'
  end
end