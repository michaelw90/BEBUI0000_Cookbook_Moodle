#
# Cookbook Name:: cookbook_moodle
# Recipe:: htpasswd
#

htpasswd_username = node['cookbook_moodle']['htpasswd']['username']
htpasswd_password = node['cookbook_moodle']['htpasswd']['password']
htpasswd_path = node['cookbook_moodle']['htpasswd']['path']

if htpasswd_username != '' && htpasswd_password != '' && htpasswd_path != ''

  htpasswd htpasswd_path do
    user htpasswd_username
    password htpasswd_password
    action :overwrite
  end

end