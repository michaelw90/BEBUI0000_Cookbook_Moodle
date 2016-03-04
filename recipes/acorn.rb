#
# Cookbook Name:: cookbook_moodle
# Recipe:: acorn
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
  

  execute "Run Composer Install" do
    cwd "#{deploy[:current_path]}/public/local/acornapi/endpoint"
    command "sudo composer install"
  end

  execute "Run Composer Install" do
    cwd "#{deploy[:deploy_to]}/shared"
    command "sudo mkdir -p public/data && chown deploy:www-data -R public && chmod -R 0777 public/*"
  end

end
