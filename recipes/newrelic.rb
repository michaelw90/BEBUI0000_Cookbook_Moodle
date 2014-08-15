#
# Cookbook Name:: cookbook_moodle
# Recipe:: newrelic
#

if node['cookbook_moodle']['newrelic']
  newrelic_licence_key = node['cookbook_moodle']['newrelic']['license_key']
  if newrelic_licence_key
    node.set['newrelic']['license'] = newrelic_licence_key
    node.set['newrelic']['server_monitoring'] = newrelic_licence_key
    node.set['newrelic']['application_monitoring'] = newrelic_licence_key
    node.set['newrelic']['plugin_monitoring'] = newrelic_licence_key
    node.set['newrelic']['install_dir'] = '/opt/newrelic'
    node.set['newrelic']['php-agent']['web_server']['service_name'] = 'nginx'
    include_recipe 'newrelic::repository'
    include_recipe 'newrelic::server-monitor-agent'
    # PHP Agent doesnt seem to work as of yet with Ubuntu 11.04.
    # It asks for a version of newrelic-php5 that doesnt exist.
    #include_recipe 'newrelic::php-agent'
  end
end