#
# Cookbook Name:: cookbook_moodle
# Recipe:: rackspace
#

if node['cookbook_moodle']['rackspace']

  rackspace_username = node['cookbook_moodle']['rackspace']['username']
  rackspace_api_key = node['cookbook_moodle']['rackspace']['api_key']
  rackspace_auth_region = node['cookbook_moodle']['rackspace']['auth_region']
  rackspace_endpoint = node['cookbook_moodle']['rackspace']['endpoint']
  rackspace_monitoring = node['cookbook_moodle']['rackspace']['monitoring']
  rackspace_backup = node['cookbook_moodle']['rackspace']['backup']
  rackspace_backup_container = node['cookbook_moodle']['rackspace']['backup_container']

  if rackspace_monitoring == true && rackspace_username != '' && rackspace_api_key != '' && rackspace_auth_region != ''

    gem_package "fog" do
      action :install
    end

    require 'fog'

    node.set['cloud_monitoring']['rackspace_username'] = rackspace_username
    node.set['cloud_monitoring']['rackspace_api_key'] = rackspace_api_key
    node.set['cloud_monitoring']['rackspace_auth_region'] = rackspace_auth_region
    include_recipe 'cloud_monitoring::agent'
  end

  if rackspace_backup == true && rackspace_username != '' && rackspace_api_key != '' && rackspace_endpoint != '' && rackspace_backup_container != ''

    node.set['rackspace_cloud_backup']['rackspace_username'] = rackspace_username
    node.set['rackspace_cloud_backup']['rackspace_apikey'] = rackspace_api_key
    node.set['rackspace_cloud_backup']['rackspace_endpoint'] = rackspace_endpoint

    node.set['rackspace_cloud_backup']['backup_cron_hour'] = '20'
    node.set['rackspace_cloud_backup']['backup_cron_day'] = '*'
    node.set['rackspace_cloud_backup']['backup_cron_weekday'] = '*'
    node.set['rackspace_cloud_backup']['backup_cron_month'] = '*'
    node.set['rackspace_cloud_backup']['backup_cron_minute'] = '30'
    node.set['rackspace_cloud_backup']['backup_cron_user'] = 'root'

    node.set['rackspace_cloud_backup']['backup_container'] = rackspace_backup_container
    node.set['rackspace_cloud_backup']['cloud_notify_email'] = 'fred.thompson@buildempire.co.uk'
    node.set['rackspace_cloud_backup']['backup_locations'] = [
      "/home"
    ]

    include_recipe 'rackspace-cloud-backup::cloud'

  end

end