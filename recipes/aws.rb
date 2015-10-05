#
# Cookbook Name:: cookbook_moodle
# Recipe:: aws
#


efs = node['cookbook_moodle']['aws']['efs']

if efs != ''

  execute "Attach EFS Share" do
  	command "mkdir /efs && sudo mount -t nfs4 $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone).#{efs}.efs.us-west-2.amazonaws.com:/ /efs"
  end

end

