#
# Cookbook Name:: cookbook_moodle
# Recipe:: aws
#


efs = node['cookbook_moodle']['aws']['efs']

if efs != ''

  execute "Attach EFS Share" do
  	command "mkdir -p /efs && sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 #{efs}.efs.us-west-2.amazonaws.com:/ /efs"
  end

end

