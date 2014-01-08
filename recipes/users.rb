#
# Cookbook Name:: cookbook_moodle
# Recipe:: users
#

# Create the moodle user account
user_account node['cookbook_moodle']['user'] do
  comment 'Moodle user'
  create_group true
end

# Append moodle to the apps group too.
group node['appbox']['apps_user'] do
  members node['cookbook_moodle']['user']
  append true
end

# Append www-data to the apps group too.
group node['appbox']['apps_user'] do
  members 'www-data'
  append true
end