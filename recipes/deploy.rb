#
# Cookbook Name:: cookbook_moodle
# Recipe:: deploy
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  execute "build LESS" do
    cwd "#{deploy[:current_path]}/public/theme/innovators"
    execute "npm install && npm install -g grunt-cli && grunt less"
  end
end