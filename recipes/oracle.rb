#
# Cookbook Name:: cookbook_moodle
# Recipe:: oracle
#

package "libicu-dev" do
  action :install
end

package "libaio1" do
  action :install
end

cookbook_file node['cookbook_moodle']['oracle']['basic_zip'] do
  path File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['basic_zip'])
  action :create_if_missing
end

cookbook_file node['cookbook_moodle']['oracle']['sdk_zip'] do
  path File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['sdk_zip'])
  action :create_if_missing
end

directory "/usr/lib/oracle" do
  action :create
  recursive true
end

execute "Unzip basic into directory" do
  command "unzip -o #{File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['basic_zip'])} -d /usr/lib/oracle/"
end

execute "Unzip sdk into directory" do
  command "unzip -o #{File.join(Chef::Config[:file_cache_path], node['cookbook_moodle']['oracle']['sdk_zip'])} -d /usr/lib/oracle/"
end

link "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libclntsh.so" do
  to "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libclntsh.so.#{node['cookbook_moodle']['oracle']['version']}"
end

link "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libocci.so" do
  to "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}/libocci.so.#{node['cookbook_moodle']['oracle']['version']}"
end

magic_shell_environment 'ORACLE_HOME' do
  value "/usr/lib/oracle/#{node['cookbook_moodle']['oracle']['folder_name']}"
end

node.set['php']['install_method'] = 'source'
node.set['php']['configure_options'] = %W{--prefix=/usr/local/php5.5.13
                                         --with-libdir=lib
                                         --with-config-file-path=/etc/php5/cli
                                         --with-config-file-scan-dir=/etc/php5/conf.d
                                         --with-pear
                                         --enable-fpm
                                         --with-fpm-user=www-data
                                         --with-fpm-group=www-data
                                         --with-zlib
                                         --with-openssl
                                         --with-kerberos
                                         --with-bz2
                                         --with-curl
                                         --enable-ftp
                                         --enable-zip
                                         --enable-exif
                                         --with-gd
                                         --enable-gd-native-ttf
                                         --with-gettext
                                         --with-gmp
                                         --with-mhash
                                         --with-iconv
                                         --with-imap
                                         --with-imap-ssl
                                         --enable-sockets
                                         --enable-soap
                                         --with-xmlrpc
                                         --with-libevent-dir
                                         --with-mcrypt
                                         --enable-mbstring
                                         --with-t1lib
                                         --enable-intl
                                         --with-pdo-oci=instantclient,/usr/lib/oracle/instantclient_12_1,12.1}